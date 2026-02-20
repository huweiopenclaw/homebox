"""
Global exception handlers and custom exceptions
"""
from fastapi import Request, status
from fastapi.responses import JSONResponse
from fastapi.exceptions import RequestValidationError
from sqlalchemy.exc import SQLAlchemyError
import logging

logger = logging.getLogger(__name__)


class HomeBoxException(Exception):
    """Base exception for HomeBox"""
    def __init__(self, message: str, status_code: int = 500, details: dict = None):
        self.message = message
        self.status_code = status_code
        self.details = details or {}
        super().__init__(self.message)


class NotFoundError(HomeBoxException):
    """Resource not found"""
    def __init__(self, message: str = "Resource not found", details: dict = None):
        super().__init__(message, status.HTTP_404_NOT_FOUND, details)


class ValidationError(HomeBoxException):
    """Validation error"""
    def __init__(self, message: str = "Validation failed", details: dict = None):
        super().__init__(message, status.HTTP_422_UNPROCESSABLE_ENTITY, details)


class AuthenticationError(HomeBoxException):
    """Authentication failed"""
    def __init__(self, message: str = "Authentication failed", details: dict = None):
        super().__init__(message, status.HTTP_401_UNAUTHORIZED, details)


class AuthorizationError(HomeBoxException):
    """Authorization failed"""
    def __init__(self, message: str = "Permission denied", details: dict = None):
        super().__init__(message, status.HTTP_403_FORBIDDEN, details)


class AIServiceError(HomeBoxException):
    """AI service error"""
    def __init__(self, message: str = "AI service error", details: dict = None):
        super().__init__(message, status.HTTP_503_SERVICE_UNAVAILABLE, details)


class RateLimitError(HomeBoxException):
    """Rate limit exceeded"""
    def __init__(self, message: str = "Rate limit exceeded", details: dict = None):
        super().__init__(message, status.HTTP_429_TOO_MANY_REQUESTS, details)


async def homebox_exception_handler(request: Request, exc: HomeBoxException):
    """Handle HomeBox exceptions"""
    logger.error(
        f"HomeBox exception: {exc.message}",
        extra={
            "status_code": exc.status_code,
            "details": exc.details,
            "path": request.url.path
        }
    )
    
    return JSONResponse(
        status_code=exc.status_code,
        content={
            "success": False,
            "error": {
                "message": exc.message,
                "type": exc.__class__.__name__,
                "details": exc.details
            }
        }
    )


async def validation_exception_handler(request: Request, exc: RequestValidationError):
    """Handle validation errors"""
    errors = []
    for error in exc.errors():
        errors.append({
            "field": ".".join(str(x) for x in error["loc"]),
            "message": error["msg"],
            "type": error["type"]
        })
    
    logger.warning(
        f"Validation error: {len(errors)} errors",
        extra={"path": request.url.path, "errors": errors}
    )
    
    return JSONResponse(
        status_code=status.HTTP_422_UNPROCESSABLE_ENTITY,
        content={
            "success": False,
            "error": {
                "message": "Validation failed",
                "type": "ValidationError",
                "details": {"errors": errors}
            }
        }
    )


async def sqlalchemy_exception_handler(request: Request, exc: SQLAlchemyError):
    """Handle database errors"""
    logger.error(
        f"Database error: {str(exc)}",
        extra={"path": request.url.path},
        exc_info=True
    )
    
    return JSONResponse(
        status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
        content={
            "success": False,
            "error": {
                "message": "Database error occurred",
                "type": "DatabaseError",
                "details": {}
            }
        }
    )


async def generic_exception_handler(request: Request, exc: Exception):
    """Handle unexpected errors"""
    logger.error(
        f"Unexpected error: {str(exc)}",
        extra={"path": request.url.path},
        exc_info=True
    )
    
    return JSONResponse(
        status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
        content={
            "success": False,
            "error": {
                "message": "An unexpected error occurred",
                "type": "InternalServerError",
                "details": {}
            }
        }
    )
