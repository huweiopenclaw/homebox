"""
SQLAlchemy database models for HomeBox
"""
from datetime import datetime
from uuid import uuid4
from sqlalchemy import (
    String, Text, Integer, Float, Boolean, DateTime, 
    ForeignKey, JSON, Enum as SQLEnum
)
from sqlalchemy.orm import Mapped, mapped_column, relationship
from sqlalchemy.dialects.postgresql import UUID as PG_UUID
import enum

from ..database import Base


def generate_uuid():
    return str(uuid4())


class SubscriptionTier(str, enum.Enum):
    FREE = "free"
    PREMIUM = "premium"
    LIFETIME = "lifetime"


class User(Base):
    """User model"""
    __tablename__ = "users"
    
    id: Mapped[str] = mapped_column(String(36), primary_key=True, default=generate_uuid)
    email: Mapped[str] = mapped_column(String(255), unique=True, nullable=False, index=True)
    password_hash: Mapped[str] = mapped_column(String(255), nullable=False)
    nickname: Mapped[str | None] = mapped_column(String(100))
    avatar_url: Mapped[str | None] = mapped_column(Text)
    subscription_tier: Mapped[str] = mapped_column(String(20), default=SubscriptionTier.FREE.value)
    subscription_expires_at: Mapped[datetime | None] = mapped_column(DateTime)
    created_at: Mapped[datetime] = mapped_column(DateTime, default=datetime.utcnow)
    updated_at: Mapped[datetime] = mapped_column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
    
    # Relationships
    boxes: Mapped[list["Box"]] = relationship("Box", back_populates="user", cascade="all, delete-orphan")
    chat_sessions: Mapped[list["ChatSession"]] = relationship("ChatSession", back_populates="user", cascade="all, delete-orphan")


class Box(Base):
    """Storage box/container model"""
    __tablename__ = "boxes"
    
    id: Mapped[str] = mapped_column(String(36), primary_key=True, default=generate_uuid)
    user_id: Mapped[str] = mapped_column(String(36), ForeignKey("users.id", ondelete="CASCADE"), nullable=False, index=True)
    name: Mapped[str] = mapped_column(String(255), nullable=False)
    category: Mapped[str | None] = mapped_column(String(100))
    
    # Location info
    room: Mapped[str | None] = mapped_column(String(100), index=True)
    furniture: Mapped[str | None] = mapped_column(String(100))
    position: Mapped[str | None] = mapped_column(String(100))
    location_description: Mapped[str | None] = mapped_column(Text)
    
    # Photos
    item_photo_url: Mapped[str | None] = mapped_column(Text)
    loc_photo_url: Mapped[str | None] = mapped_column(Text)
    
    # AI recognition cache
    item_recognition: Mapped[dict | None] = mapped_column(JSON)
    location_recognition: Mapped[dict | None] = mapped_column(JSON)
    
    created_at: Mapped[datetime] = mapped_column(DateTime, default=datetime.utcnow)
    updated_at: Mapped[datetime] = mapped_column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
    
    # Relationships
    user: Mapped["User"] = relationship("User", back_populates="boxes")
    items: Mapped[list["Item"]] = relationship("Item", back_populates="box", cascade="all, delete-orphan")


class Item(Base):
    """Item in a box model"""
    __tablename__ = "items"
    
    id: Mapped[str] = mapped_column(String(36), primary_key=True, default=generate_uuid)
    box_id: Mapped[str] = mapped_column(String(36), ForeignKey("boxes.id", ondelete="CASCADE"), nullable=False, index=True)
    name: Mapped[str] = mapped_column(String(255), nullable=False, index=True)
    quantity: Mapped[int] = mapped_column(Integer, default=1)
    note: Mapped[str | None] = mapped_column(Text)
    expiry_date: Mapped[datetime | None] = mapped_column(DateTime)
    
    # AI confidence
    confidence: Mapped[float | None] = mapped_column(Float)
    
    # User modified flag
    user_modified: Mapped[bool] = mapped_column(Boolean, default=False)
    
    created_at: Mapped[datetime] = mapped_column(DateTime, default=datetime.utcnow)
    updated_at: Mapped[datetime] = mapped_column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
    
    # Relationships
    box: Mapped["Box"] = relationship("Box", back_populates="items")


class ChatSession(Base):
    """Chat session model"""
    __tablename__ = "chat_sessions"
    
    id: Mapped[str] = mapped_column(String(36), primary_key=True, default=generate_uuid)
    user_id: Mapped[str] = mapped_column(String(36), ForeignKey("users.id", ondelete="CASCADE"), nullable=False, index=True)
    title: Mapped[str | None] = mapped_column(String(255))
    created_at: Mapped[datetime] = mapped_column(DateTime, default=datetime.utcnow)
    updated_at: Mapped[datetime] = mapped_column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
    
    # Relationships
    user: Mapped["User"] = relationship("User", back_populates="chat_sessions")
    messages: Mapped[list["ChatMessage"]] = relationship("ChatMessage", back_populates="session", cascade="all, delete-orphan")


class ChatMessage(Base):
    """Chat message model"""
    __tablename__ = "chat_messages"
    
    id: Mapped[str] = mapped_column(String(36), primary_key=True, default=generate_uuid)
    session_id: Mapped[str] = mapped_column(String(36), ForeignKey("chat_sessions.id", ondelete="CASCADE"), nullable=False, index=True)
    role: Mapped[str] = mapped_column(String(20), nullable=False)  # user, assistant
    content: Mapped[str] = mapped_column(Text, nullable=False)
    
    # Related boxes (for search results)
    related_boxes: Mapped[list | None] = mapped_column(JSON)
    
    created_at: Mapped[datetime] = mapped_column(DateTime, default=datetime.utcnow)
    
    # Relationships
    session: Mapped["ChatSession"] = relationship("ChatSession", back_populates="messages")
