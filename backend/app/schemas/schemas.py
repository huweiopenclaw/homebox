"""
Pydantic schemas for API request/response validation
"""
from datetime import datetime
from typing import Optional, List
from pydantic import BaseModel, EmailStr, Field


# ============ User Schemas ============

class UserBase(BaseModel):
    email: EmailStr
    nickname: Optional[str] = None


class UserCreate(UserBase):
    password: str = Field(..., min_length=6, max_length=100)


class UserLogin(BaseModel):
    email: EmailStr
    password: str


class UserResponse(UserBase):
    id: str
    avatar_url: Optional[str] = None
    subscription_tier: str
    created_at: datetime
    
    class Config:
        from_attributes = True


class TokenResponse(BaseModel):
    access_token: str
    refresh_token: str
    token_type: str = "bearer"
    expires_in: int


# ============ Box Schemas ============

class LocationInfo(BaseModel):
    room: Optional[str] = None
    furniture: Optional[str] = None
    position: Optional[str] = None
    description: Optional[str] = None


class ItemBase(BaseModel):
    name: str
    quantity: int = 1
    note: Optional[str] = None
    expiry_date: Optional[datetime] = None


class ItemCreate(ItemBase):
    confidence: Optional[float] = None


class ItemResponse(ItemBase):
    id: str
    box_id: str
    confidence: Optional[float] = None
    user_modified: bool
    created_at: datetime
    
    class Config:
        from_attributes = True


class BoxBase(BaseModel):
    name: str
    category: Optional[str] = None


class BoxCreate(BoxBase):
    item_photo: Optional[str] = None  # Base64 encoded image
    loc_photo: Optional[str] = None   # Base64 encoded image
    auto_recognize: bool = True


class BoxUpdate(BaseModel):
    name: Optional[str] = None
    category: Optional[str] = None
    room: Optional[str] = None
    furniture: Optional[str] = None
    position: Optional[str] = None


class BoxResponse(BoxBase):
    id: str
    user_id: str
    location: Optional[LocationInfo] = None
    items: List[ItemResponse] = []
    item_photo_url: Optional[str] = None
    loc_photo_url: Optional[str] = None
    created_at: datetime
    updated_at: datetime
    
    class Config:
        from_attributes = True


class BoxListResponse(BaseModel):
    boxes: List[BoxResponse]
    total: int


# ============ AI Recognition Schemas ============

class RecognizedItem(BaseModel):
    name: str
    quantity: int
    confidence: float
    note: Optional[str] = None


class ItemRecognitionResult(BaseModel):
    items: List[RecognizedItem]
    summary: str


class LocationRecognitionResult(BaseModel):
    room: str
    furniture: Optional[str] = None
    position: Optional[str] = None
    description: str
    landmarks: List[str] = []


class RecognizeItemsRequest(BaseModel):
    image: str  # Base64 encoded image


class RecognizeItemsResponse(BaseModel):
    result: ItemRecognitionResult


class RecognizeLocationRequest(BaseModel):
    image: str  # Base64 encoded image


class RecognizeLocationResponse(BaseModel):
    result: LocationRecognitionResult


# ============ Chat Schemas ============

class ChatMessageBase(BaseModel):
    content: str


class ChatMessageCreate(ChatMessageBase):
    session_id: Optional[str] = None


class ChatMessageResponse(ChatMessageBase):
    id: str
    session_id: str
    role: str
    related_boxes: Optional[List[str]] = None
    created_at: datetime
    
    class Config:
        from_attributes = True


class ChatSessionResponse(BaseModel):
    id: str
    title: Optional[str] = None
    created_at: datetime
    updated_at: datetime
    messages: List[ChatMessageResponse] = []
    
    class Config:
        from_attributes = True


class ChatSessionListResponse(BaseModel):
    sessions: List[ChatSessionResponse]
    total: int


# ============ Common Schemas ============

class MessageResponse(BaseModel):
    message: str
    success: bool = True


class ErrorResponse(BaseModel):
    detail: str
    error_code: Optional[str] = None
