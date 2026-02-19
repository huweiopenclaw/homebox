"""
AI Recognition API endpoints
"""
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.ext.asyncio import AsyncSession

from ...database import get_db
from ...core.security import get_current_user
from ...models.models import User
from ...services import ai_service
from ...schemas import (
    RecognizeItemsRequest, RecognizeItemsResponse,
    RecognizeLocationRequest, RecognizeLocationResponse,
    ItemRecognitionResult, LocationRecognitionResult
)

router = APIRouter(prefix="/ai", tags=["AI Recognition"])


@router.post("/recognize-items", response_model=RecognizeItemsResponse)
async def recognize_items(
    request: RecognizeItemsRequest,
    current_user: User = Depends(get_current_user)
):
    """Recognize items in an image"""
    try:
        result = await ai_service.recognize_items(request.image)
        return RecognizeItemsResponse(
            result=ItemRecognitionResult(**result)
        )
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"AI recognition failed: {str(e)}")


@router.post("/recognize-location", response_model=RecognizeLocationResponse)
async def recognize_location(
    request: RecognizeLocationRequest,
    current_user: User = Depends(get_current_user)
):
    """Recognize location from an image"""
    try:
        result = await ai_service.recognize_location(request.image)
        return RecognizeLocationResponse(
            result=LocationRecognitionResult(**result)
        )
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"AI recognition failed: {str(e)}")
