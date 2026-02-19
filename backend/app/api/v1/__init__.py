"""
API v1 routes
"""
from fastapi import APIRouter

from .auth import router as auth_router
from .boxes import router as boxes_router
from .ai import router as ai_router
from .chat import router as chat_router

router = APIRouter(prefix="/v1")

router.include_router(auth_router)
router.include_router(boxes_router)
router.include_router(ai_router)
router.include_router(chat_router)
