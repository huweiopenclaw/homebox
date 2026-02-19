"""
User repository for database operations
"""
from typing import Optional
from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession

from ..models.models import User
from ..core.security import get_password_hash, verify_password


class UserRepository:
    """Repository for User model"""
    
    def __init__(self, db: AsyncSession):
        self.db = db
    
    async def create(self, email: str, password: str, nickname: Optional[str] = None) -> User:
        """Create a new user"""
        user = User(
            email=email,
            password_hash=get_password_hash(password),
            nickname=nickname or email.split("@")[0]
        )
        self.db.add(user)
        await self.db.flush()
        await self.db.refresh(user)
        return user
    
    async def get_by_id(self, user_id: str) -> Optional[User]:
        """Get user by ID"""
        result = await self.db.execute(
            select(User).where(User.id == user_id)
        )
        return result.scalar_one_or_none()
    
    async def get_by_email(self, email: str) -> Optional[User]:
        """Get user by email"""
        result = await self.db.execute(
            select(User).where(User.email == email)
        )
        return result.scalar_one_or_none()
    
    async def authenticate(self, email: str, password: str) -> Optional[User]:
        """Authenticate user with email and password"""
        user = await self.get_by_email(email)
        if not user:
            return None
        if not verify_password(password, user.password_hash):
            return None
        return user
    
    async def update(self, user: User, **kwargs) -> User:
        """Update user fields"""
        for key, value in kwargs.items():
            if hasattr(user, key):
                setattr(user, key, value)
        await self.db.flush()
        await self.db.refresh(user)
        return user
    
    async def delete(self, user: User) -> bool:
        """Delete user"""
        await self.db.delete(user)
        await self.db.flush()
        return True
