"""
Chat repository for database operations
"""
from typing import Optional, List
from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.orm import selectinload

from ..models.models import ChatSession, ChatMessage


class ChatRepository:
    """Repository for Chat models"""
    
    def __init__(self, db: AsyncSession):
        self.db = db
    
    # Session operations
    async def create_session(self, user_id: str, title: Optional[str] = None) -> ChatSession:
        """Create a new chat session"""
        session = ChatSession(user_id=user_id, title=title)
        self.db.add(session)
        await self.db.flush()
        await self.db.refresh(session)
        return session
    
    async def get_session(self, session_id: str) -> Optional[ChatSession]:
        """Get session by ID"""
        result = await self.db.execute(
            select(ChatSession)
            .where(ChatSession.id == session_id)
            .options(selectinload(ChatSession.messages))
        )
        return result.scalar_one_or_none()
    
    async def get_user_sessions(
        self, 
        user_id: str, 
        limit: int = 20,
        offset: int = 0
    ) -> List[ChatSession]:
        """Get user's chat sessions"""
        result = await self.db.execute(
            select(ChatSession)
            .where(ChatSession.user_id == user_id)
            .order_by(ChatSession.updated_at.desc())
            .limit(limit)
            .offset(offset)
        )
        return list(result.scalars().all())
    
    async def delete_session(self, session: ChatSession) -> bool:
        """Delete chat session"""
        await self.db.delete(session)
        await self.db.flush()
        return True
    
    # Message operations
    async def add_message(
        self,
        session_id: str,
        role: str,
        content: str,
        related_boxes: Optional[List[str]] = None
    ) -> ChatMessage:
        """Add a message to session"""
        message = ChatMessage(
            session_id=session_id,
            role=role,
            content=content,
            related_boxes=related_boxes
        )
        self.db.add(message)
        await self.db.flush()
        await self.db.refresh(message)
        return message
    
    async def get_session_messages(
        self, 
        session_id: str,
        limit: int = 50
    ) -> List[ChatMessage]:
        """Get messages in a session"""
        result = await self.db.execute(
            select(ChatMessage)
            .where(ChatMessage.session_id == session_id)
            .order_by(ChatMessage.created_at.asc())
            .limit(limit)
        )
        return list(result.scalars().all())
