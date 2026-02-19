"""
Box management API endpoints
"""
from fastapi import APIRouter, Depends, HTTPException, status, Query
from sqlalchemy.ext.asyncio import AsyncSession
from typing import Optional

from ...database import get_db
from ...core.security import get_current_user
from ...models.models import User
from ...repositories.box import BoxRepository, ItemRepository
from ...services import ai_service, storage_service
from ...schemas import (
    BoxCreate, BoxUpdate, BoxResponse, BoxListResponse,
    ItemCreate, ItemResponse, MessageResponse
)

router = APIRouter(prefix="/boxes", tags=["Boxes"])


@router.get("", response_model=BoxListResponse)
async def list_boxes(
    room: Optional[str] = Query(None),
    category: Optional[str] = Query(None),
    limit: int = Query(50, le=100),
    offset: int = Query(0, ge=0),
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db)
):
    """Get list of user's boxes"""
    box_repo = BoxRepository(db)
    boxes = await box_repo.get_by_user(
        user_id=current_user.id,
        room=room,
        category=category,
        limit=limit,
        offset=offset
    )
    total = await box_repo.count_by_user(current_user.id)
    
    return BoxListResponse(
        boxes=[BoxResponse.model_validate(box) for box in boxes],
        total=total
    )


@router.post("", response_model=BoxResponse, status_code=status.HTTP_201_CREATED)
async def create_box(
    box_data: BoxCreate,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db)
):
    """Create a new box with optional AI recognition"""
    box_repo = BoxRepository(db)
    item_repo = ItemRepository(db)
    
    # Initialize variables
    item_photo_url = None
    loc_photo_url = None
    item_recognition = None
    location_recognition = None
    room, furniture, position, location_description = None, None, None, None
    
    # Process item photo
    if box_data.item_photo:
        item_photo_url = await storage_service.save_image(
            box_data.item_photo,
            current_user.id,
            prefix="items"
        )
        
        # AI recognition
        if box_data.auto_recognize:
            try:
                item_recognition = await ai_service.recognize_items(box_data.item_photo)
            except Exception as e:
                print(f"AI recognition failed: {e}")
    
    # Process location photo
    if box_data.loc_photo:
        loc_photo_url = await storage_service.save_image(
            box_data.loc_photo,
            current_user.id,
            prefix="locations"
        )
        
        # AI location recognition
        if box_data.auto_recognize:
            try:
                location_recognition = await ai_service.recognize_location(box_data.loc_photo)
                room = location_recognition.get("room")
                furniture = location_recognition.get("furniture")
                position = location_recognition.get("position")
                location_description = location_recognition.get("description")
            except Exception as e:
                print(f"Location recognition failed: {e}")
    
    # Create box
    box = await box_repo.create(
        user_id=current_user.id,
        name=box_data.name,
        category=box_data.category,
        room=room,
        furniture=furniture,
        position=position,
        location_description=location_description,
        item_photo_url=item_photo_url,
        loc_photo_url=loc_photo_url,
        item_recognition=item_recognition,
        location_recognition=location_recognition
    )
    
    # Create items from recognition
    if item_recognition and "items" in item_recognition:
        await item_repo.create_bulk(item_recognition["items"], box.id)
    
    # Reload with items
    box = await box_repo.get_by_id(box.id)
    
    return BoxResponse.model_validate(box)


@router.get("/{box_id}", response_model=BoxResponse)
async def get_box(
    box_id: str,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db)
):
    """Get box details"""
    box_repo = BoxRepository(db)
    box = await box_repo.get_by_id(box_id)
    
    if not box:
        raise HTTPException(status_code=404, detail="Box not found")
    
    if box.user_id != current_user.id:
        raise HTTPException(status_code=403, detail="Access denied")
    
    return BoxResponse.model_validate(box)


@router.put("/{box_id}", response_model=BoxResponse)
async def update_box(
    box_id: str,
    box_data: BoxUpdate,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db)
):
    """Update box information"""
    box_repo = BoxRepository(db)
    box = await box_repo.get_by_id(box_id)
    
    if not box:
        raise HTTPException(status_code=404, detail="Box not found")
    
    if box.user_id != current_user.id:
        raise HTTPException(status_code=403, detail="Access denied")
    
    update_data = box_data.model_dump(exclude_unset=True)
    box = await box_repo.update(box, **update_data)
    
    return BoxResponse.model_validate(box)


@router.delete("/{box_id}", response_model=MessageResponse)
async def delete_box(
    box_id: str,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db)
):
    """Delete a box"""
    box_repo = BoxRepository(db)
    box = await box_repo.get_by_id(box_id)
    
    if not box:
        raise HTTPException(status_code=404, detail="Box not found")
    
    if box.user_id != current_user.id:
        raise HTTPException(status_code=403, detail="Access denied")
    
    await box_repo.delete(box)
    
    return MessageResponse(message="Box deleted successfully")


@router.get("/search/items", response_model=BoxListResponse)
async def search_items(
    q: str = Query(..., min_length=1),
    room: Optional[str] = Query(None),
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db)
):
    """Search boxes by item name"""
    box_repo = BoxRepository(db)
    boxes = await box_repo.search_items(
        user_id=current_user.id,
        item_name=q,
        room=room
    )
    
    return BoxListResponse(
        boxes=[BoxResponse.model_validate(box) for box in boxes],
        total=len(boxes)
    )


# Item endpoints
@router.post("/{box_id}/items", response_model=ItemResponse, status_code=status.HTTP_201_CREATED)
async def add_item(
    box_id: str,
    item_data: ItemCreate,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db)
):
    """Add item to box"""
    box_repo = BoxRepository(db)
    item_repo = ItemRepository(db)
    
    box = await box_repo.get_by_id(box_id)
    if not box or box.user_id != current_user.id:
        raise HTTPException(status_code=404, detail="Box not found")
    
    item = await item_repo.create(
        box_id=box_id,
        name=item_data.name,
        quantity=item_data.quantity,
        note=item_data.note,
        confidence=item_data.confidence
    )
    
    return ItemResponse.model_validate(item)


@router.put("/items/{item_id}", response_model=ItemResponse)
async def update_item(
    item_id: str,
    item_data: ItemCreate,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db)
):
    """Update item"""
    item_repo = ItemRepository(db)
    box_repo = BoxRepository(db)
    
    item = await item_repo.get_by_id(item_id)
    if not item:
        raise HTTPException(status_code=404, detail="Item not found")
    
    box = await box_repo.get_by_id(item.box_id)
    if box.user_id != current_user.id:
        raise HTTPException(status_code=403, detail="Access denied")
    
    update_data = item_data.model_dump(exclude_unset=True)
    item = await item_repo.update(item, **update_data)
    
    return ItemResponse.model_validate(item)


@router.delete("/items/{item_id}", response_model=MessageResponse)
async def delete_item(
    item_id: str,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db)
):
    """Delete item"""
    item_repo = ItemRepository(db)
    box_repo = BoxRepository(db)
    
    item = await item_repo.get_by_id(item_id)
    if not item:
        raise HTTPException(status_code=404, detail="Item not found")
    
    box = await box_repo.get_by_id(item.box_id)
    if box.user_id != current_user.id:
        raise HTTPException(status_code=403, detail="Access denied")
    
    await item_repo.delete(item)
    
    return MessageResponse(message="Item deleted successfully")
