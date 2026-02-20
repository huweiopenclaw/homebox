"""
Core configuration for HomeBox Backend
"""
from pydantic_settings import BaseSettings
from typing import Optional
from functools import lru_cache


class Settings(BaseSettings):
    """Application settings"""
    
    # App
    APP_NAME: str = "HomeBox API"
    APP_VERSION: str = "1.0.0"
    DEBUG: bool = True
    
    # Server
    HOST: str = "0.0.0.0"
    PORT: int = 8000
    
    # Database
    DATABASE_URL: str = "sqlite+aiosqlite:///./homebox.db"
    # For production: "postgresql+asyncpg://user:pass@localhost/homebox"
    
    # Redis
    REDIS_URL: Optional[str] = None
    
    # Security
    SECRET_KEY: str = "your-secret-key-change-in-production"
    ALGORITHM: str = "HS256"
    ACCESS_TOKEN_EXPIRE_MINUTES: int = 15
    REFRESH_TOKEN_EXPIRE_DAYS: int = 7
    
    # AI Services
    # GLM-4V for image recognition
    GLM_API_KEY: Optional[str] = None
    GLM_API_URL: str = "https://open.bigmodel.cn/api/paas/v4/chat/completions"
    
    # Or use Claude
    CLAUDE_API_KEY: Optional[str] = None
    CLAUDE_API_URL: str = "https://api.anthropic.com/v1/messages"
    
    # Storage
    STORAGE_TYPE: str = "local"  # local, s3, oss
    UPLOAD_DIR: str = "./uploads"
    
    # Aliyun OSS
    OSS_ACCESS_KEY_ID: Optional[str] = None
    OSS_ACCESS_KEY_SECRET: Optional[str] = None
    OSS_ENDPOINT: Optional[str] = None
    OSS_BUCKET_NAME: Optional[str] = None
    
    # CORS
    CORS_ORIGINS: list = ["*"]
    
    # Rate Limiting
    RATE_LIMIT_REQUESTS: int = 100
    RATE_LIMIT_PERIOD: int = 60
    
    # Logging
    LOG_LEVEL: str = "INFO"
    LOG_FORMAT: str = "json"  # json or text
    
    class Config:
        env_file = ".env"
        case_sensitive = True


@lru_cache()
def get_settings() -> Settings:
    return Settings()


settings = get_settings()
