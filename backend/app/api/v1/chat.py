"""
Chat API endpoints
"""
from fastapi import APIRouter, Depends, HTTPException, Query
from fastapi.responses import StreamingResponse
from sqlalchemy.ext.asyncio import AsyncSession
from typing import Optional
import json

from ...database import get_db
from ...core.security import get_current_user
from ...models.models import User
from ...repositories.box import BoxRepository
from ...repositories.chat import ChatRepository
from ...services import ai_service
from ...schemas import (
    ChatMessageCreate, ChatMessageResponse,
    ChatSessionResponse, ChatSessionListResponse,
    MessageResponse
)

router = APIRouter(prefix="/chat", tags=["Chat"])


def build_context(boxes: list) -> str:
    """Build context string from boxes data"""
    if not boxes:
        return "用户还没有记录任何箱子。"
    
    context_parts = []
    for box in boxes:
        items_str = ", ".join([f"{i.name}x{i.quantity}" for i in box.items])
        location = box.location_description or f"{box.room or ''}{box.furniture or ''}{box.position or ''}"
        context_parts.append(f"- 【{box.name}】: {items_str} (位置: {location})")
    
    return "\n".join(context_parts)


@router.post("", response_model=ChatMessageResponse)
async def send_message(
    message_data: ChatMessageCreate,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db)
):
    """Send a chat message and get AI response"""
    chat_repo = ChatRepository(db)
    box_repo = BoxRepository(db)
    
    # Get or create session
    if message_data.session_id:
        session = await chat_repo.get_session(message_data.session_id)
        if not session or session.user_id != current_user.id:
            raise HTTPException(status_code=404, detail="Session not found")
    else:
        session = await chat_repo.create_session(
            user_id=current_user.id,
            title=message_data.content[:50] + "..."
        )
    
    # Save user message
    await chat_repo.add_message(
        session_id=session.id,
        role="user",
        content=message_data.content
    )
    
    # Classify intent
    intent = await ai_service.classify_intent(message_data.content)
    
    # Get relevant boxes
    related_box_ids = []
    
    if intent == "find_item":
        entities = await ai_service.extract_entities(message_data.content)
        item_name = entities.get("item")
        room = entities.get("room")
        boxes = await box_repo.search_items(
            user_id=current_user.id,
            item_name=item_name,
            room=room
        )
        related_box_ids = [box.id for box in boxes]
    
    elif intent == "list_boxes":
        entities = await ai_service.extract_entities(message_data.content)
        room = entities.get("room")
        boxes = await box_repo.get_by_user(
            user_id=current_user.id,
            room=room
        )
        related_box_ids = [box.id for box in boxes]
    
    else:
        # Get all boxes for context
        boxes = await box_repo.get_by_user(user_id=current_user.id, limit=20)
    
    # Build context
    context = build_context(boxes) if 'boxes' in dir() else ""
    
    # Get AI response
    ai_response = await ai_service.chat(
        user_message=message_data.content,
        context=context
    )
    
    # Save assistant message
    assistant_msg = await chat_repo.add_message(
        session_id=session.id,
        role="assistant",
        content=ai_response,
        related_boxes=related_box_ids if related_box_ids else None
    )
    
    return ChatMessageResponse.model_validate(assistant_msg)


@router.get("/sessions", response_model=ChatSessionListResponse)
async def list_sessions(
    limit: int = Query(20, le=50),
    offset: int = Query(0, ge=0),
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db)
):
    """Get list of chat sessions"""
    chat_repo = ChatRepository(db)
    sessions = await chat_repo.get_user_sessions(
        user_id=current_user.id,
        limit=limit,
        offset=offset
    )
    
    return ChatSessionListResponse(
        sessions=[ChatSessionResponse.model_validate(s) for s in sessions],
        total=len(sessions)
    )


@router.get("/sessions/{session_id}", response_model=ChatSessionResponse)
async def get_session(
    session_id: str,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db)
):
    """Get chat session with messages"""
    chat_repo = ChatRepository(db)
    session = await chat_repo.get_session(session_id)
    
    if not session:
        raise HTTPException(status_code=404, detail="Session not found")
    
    if session.user_id != current_user.id:
        raise HTTPException(status_code=403, detail="Access denied")
    
    return ChatSessionResponse.model_validate(session)


@router.delete("/sessions/{session_id}", response_model=MessageResponse)
async def delete_session(
    session_id: str,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db)
):
    """Delete chat session"""
    chat_repo = ChatRepository(db)
    session = await chat_repo.get_session(session_id)
    
    if not session:
        raise HTTPException(status_code=404, detail="Session not found")
    
    if session.user_id != current_user.id:
        raise HTTPException(status_code=403, detail="Access denied")
    
    await chat_repo.delete_session(session)
    
    return MessageResponse(message="Session deleted successfully")
