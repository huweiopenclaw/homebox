"""
Authentication API endpoints
"""
from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.ext.asyncio import AsyncSession

from ...database import get_db
from ...repositories.user import UserRepository
from ...core.security import create_access_token, create_refresh_token
from ...schemas import UserCreate, UserLogin, UserResponse, TokenResponse, MessageResponse

router = APIRouter(prefix="/auth", tags=["Authentication"])


@router.post("/register", response_model=UserResponse, status_code=status.HTTP_201_CREATED)
async def register(
    user_data: UserCreate,
    db: AsyncSession = Depends(get_db)
):
    """Register a new user"""
    user_repo = UserRepository(db)
    
    # Check if user exists
    existing = await user_repo.get_by_email(user_data.email)
    if existing:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Email already registered"
        )
    
    # Create user
    user = await user_repo.create(
        email=user_data.email,
        password=user_data.password,
        nickname=user_data.nickname
    )
    
    return UserResponse.model_validate(user)


@router.post("/login", response_model=TokenResponse)
async def login(
    credentials: UserLogin,
    db: AsyncSession = Depends(get_db)
):
    """Login and get tokens"""
    user_repo = UserRepository(db)
    
    user = await user_repo.authenticate(credentials.email, credentials.password)
    if not user:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Incorrect email or password"
        )
    
    # Create tokens
    access_token = create_access_token(data={"sub": user.id})
    refresh_token = create_refresh_token(data={"sub": user.id})
    
    return TokenResponse(
        access_token=access_token,
        refresh_token=refresh_token
    )


@router.get("/me", response_model=UserResponse)
async def get_current_user_info(
    current_user = Depends(...)
):
    """Get current user info - requires auth dependency"""
    from ...core.security import get_current_user
    # This will be protected by auth middleware
    pass


@router.post("/logout", response_model=MessageResponse)
async def logout():
    """Logout (client should discard tokens)"""
    return MessageResponse(message="Successfully logged out")
