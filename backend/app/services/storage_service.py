"""
Storage service for file uploads
"""
import os
import uuid
import base64
from datetime import datetime
from typing import Optional
from pathlib import Path

from ..core.config import settings


class StorageService:
    """Service for file storage operations"""
    
    def __init__(self):
        self.upload_dir = Path(settings.UPLOAD_DIR)
        self.upload_dir.mkdir(parents=True, exist_ok=True)
    
    async def save_image(
        self, 
        image_base64: str, 
        user_id: str,
        prefix: str = "img"
    ) -> str:
        """
        Save base64 image to storage
        Returns: relative URL path
        """
        # Decode base64
        if "," in image_base64:
            image_base64 = image_base64.split(",")[1]
        
        image_data = base64.b64decode(image_base64)
        
        # Generate filename
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        unique_id = str(uuid.uuid4())[:8]
        filename = f"{prefix}_{user_id}_{timestamp}_{unique_id}.jpg"
        
        # Create user directory
        user_dir = self.upload_dir / user_id
        user_dir.mkdir(parents=True, exist_ok=True)
        
        # Save file
        file_path = user_dir / filename
        with open(file_path, "wb") as f:
            f.write(image_data)
        
        # Return relative URL
        return f"/uploads/{user_id}/{filename}"
    
    async def delete_image(self, url: str) -> bool:
        """Delete image by URL"""
        if not url.startswith("/uploads/"):
            return False
        
        file_path = self.upload_dir.parent / url.lstrip("/")
        if file_path.exists():
            file_path.unlink()
            return True
        return False
    
    def get_full_path(self, url: str) -> Optional[Path]:
        """Get full filesystem path from URL"""
        if not url.startswith("/uploads/"):
            return None
        return self.upload_dir.parent / url.lstrip("/")


# Singleton instance
storage_service = StorageService()
