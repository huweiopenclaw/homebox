"""
Box repository for database operations
"""
from typing import Optional, List
from sqlalchemy import select, func
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.orm import selectinload

from ..models.models import Box, Item


class BoxRepository:
    """Repository for Box model"""
    
    def __init__(self, db: AsyncSession):
        self.db = db
    
    async def create(
        self, 
        user_id: str,
        name: str,
        category: Optional[str] = None,
        room: Optional[str] = None,
        furniture: Optional[str] = None,
        position: Optional[str] = None,
        location_description: Optional[str] = None,
        item_photo_url: Optional[str] = None,
        loc_photo_url: Optional[str] = None,
        item_recognition: Optional[dict] = None,
        location_recognition: Optional[dict] = None
    ) -> Box:
        """Create a new box"""
        box = Box(
            user_id=user_id,
            name=name,
            category=category,
            room=room,
            furniture=furniture,
            position=position,
            location_description=location_description,
            item_photo_url=item_photo_url,
            loc_photo_url=loc_photo_url,
            item_recognition=item_recognition,
            location_recognition=location_recognition
        )
        self.db.add(box)
        await self.db.flush()
        await self.db.refresh(box)
        return box
    
    async def get_by_id(self, box_id: str, include_items: bool = True) -> Optional[Box]:
        """Get box by ID"""
        query = select(Box).where(Box.id == box_id)
        if include_items:
            query = query.options(selectinload(Box.items))
        result = await self.db.execute(query)
        return result.scalar_one_or_none()
    
    async def get_by_user(
        self, 
        user_id: str,
        room: Optional[str] = None,
        category: Optional[str] = None,
        limit: int = 50,
        offset: int = 0
    ) -> List[Box]:
        """Get boxes by user with optional filters"""
        query = select(Box).where(Box.user_id == user_id)
        
        if room:
            query = query.where(Box.room == room)
        if category:
            query = query.where(Box.category == category)
        
        query = query.options(selectinload(Box.items))
        query = query.order_by(Box.created_at.desc())
        query = query.limit(limit).offset(offset)
        
        result = await self.db.execute(query)
        return list(result.scalars().all())
    
    async def count_by_user(self, user_id: str) -> int:
        """Count boxes by user"""
        result = await self.db.execute(
            select(func.count(Box.id)).where(Box.user_id == user_id)
        )
        return result.scalar() or 0
    
    async def search_items(
        self,
        user_id: str,
        item_name: Optional[str] = None,
        room: Optional[str] = None
    ) -> List[Box]:
        """Search boxes containing specific items"""
        query = select(Box).where(Box.user_id == user_id)
        
        if room:
            query = query.where(Box.room == room)
        
        if item_name:
            query = query.join(Item).where(Item.name.ilike(f"%{item_name}%"))
        
        query = query.options(selectinload(Box.items))
        query = query.distinct()
        
        result = await self.db.execute(query)
        return list(result.scalars().all())
    
    async def update(self, box: Box, **kwargs) -> Box:
        """Update box fields"""
        for key, value in kwargs.items():
            if hasattr(box, key):
                setattr(box, key, value)
        await self.db.flush()
        await self.db.refresh(box)
        return box
    
    async def delete(self, box: Box) -> bool:
        """Delete box and all its items"""
        await self.db.delete(box)
        await self.db.flush()
        return True


class ItemRepository:
    """Repository for Item model"""
    
    def __init__(self, db: AsyncSession):
        self.db = db
    
    async def create(
        self,
        box_id: str,
        name: str,
        quantity: int = 1,
        note: Optional[str] = None,
        confidence: Optional[float] = None
    ) -> Item:
        """Create a new item"""
        item = Item(
            box_id=box_id,
            name=name,
            quantity=quantity,
            note=note,
            confidence=confidence
        )
        self.db.add(item)
        await self.db.flush()
        await self.db.refresh(item)
        return item
    
    async def create_bulk(self, items: List[dict], box_id: str) -> List[Item]:
        """Create multiple items at once"""
        created_items = []
        for item_data in items:
            item = await self.create(
                box_id=box_id,
                name=item_data["name"],
                quantity=item_data.get("quantity", 1),
                note=item_data.get("note"),
                confidence=item_data.get("confidence")
            )
            created_items.append(item)
        return created_items
    
    async def get_by_id(self, item_id: str) -> Optional[Item]:
        """Get item by ID"""
        result = await self.db.execute(
            select(Item).where(Item.id == item_id)
        )
        return result.scalar_one_or_none()
    
    async def get_by_box(self, box_id: str) -> List[Item]:
        """Get all items in a box"""
        result = await self.db.execute(
            select(Item).where(Item.box_id == box_id)
        )
        return list(result.scalars().all())
    
    async def update(self, item: Item, **kwargs) -> Item:
        """Update item fields"""
        for key, value in kwargs.items():
            if hasattr(item, key):
                setattr(item, key, value)
        item.user_modified = True
        await self.db.flush()
        await self.db.refresh(item)
        return item
    
    async def delete(self, item: Item) -> bool:
        """Delete item"""
        await self.db.delete(item)
        await self.db.flush()
        return True
