"""
Tests for API endpoints
"""
import pytest
from fastapi.testclient import TestClient
from httpx import AsyncClient
import sys
sys.path.insert(0, "..")

from app.main import app


client = TestClient(app)


def test_health_check():
    """Test health check endpoint"""
    response = client.get("/health")
    assert response.status_code == 200
    data = response.json()
    assert data["status"] == "healthy"
    assert "version" in data


def test_root_endpoint():
    """Test root endpoint"""
    response = client.get("/")
    assert response.status_code == 200
    data = response.json()
    assert "message" in data
    assert "Welcome" in data["message"]


def test_api_docs():
    """Test API documentation endpoint"""
    response = client.get("/docs")
    assert response.status_code == 200


def test_register_user_validation():
    """Test user registration with invalid data"""
    # Missing required fields
    response = client.post("/api/auth/register", json={})
    assert response.status_code == 422
    
    # Invalid email
    response = client.post(
        "/api/auth/register",
        json={
            "email": "invalid-email",
            "password": "test123"
        }
    )
    assert response.status_code == 422


def test_login_validation():
    """Test login validation"""
    # Missing fields
    response = client.post("/api/auth/login", json={})
    assert response.status_code == 422


def test_protected_endpoint_without_auth():
    """Test accessing protected endpoint without authentication"""
    response = client.get("/api/auth/me")
    assert response.status_code == 403  # Forbidden without token


def test_error_format():
    """Test error response format"""
    response = client.get("/api/boxes/nonexistent-id")
    assert response.status_code in [401, 404, 403]  # Unauthorized or Not Found
    
    # Check error format
    if response.status_code != 401:  # Not Unauthorized
        data = response.json()
        assert "success" in data
        assert data["success"] is False
        assert "error" in data


def test_request_id_header():
    """Test that responses include request ID"""
    response = client.get("/health")
    assert "X-Request-ID" in response.headers
    assert response.headers["X-Request-ID"] != ""


def test_response_time_header():
    """Test that responses include timing"""
    response = client.get("/health")
    assert "X-Response-Time" in response.headers


@pytest.mark.asyncio
async def test_async_health_check():
    """Test health check with async client"""
    async with AsyncClient(app=app, base_url="http://test") as ac:
        response = await ac.get("/health")
        assert response.status_code == 200
        data = response.json()
        assert data["status"] == "healthy"


# Integration tests
class TestUserFlow:
    """Test complete user flow"""
    
    def test_complete_user_flow(self):
        """Test register, login, and access protected endpoint"""
        # 1. Register
        register_data = {
            "email": "test@example.com",
            "password": "testpassword123",
            "nickname": "Test User"
        }
        
        response = client.post("/api/auth/register", json=register_data)
        # May fail if user already exists
        if response.status_code == 201:
            assert "id" in response.json()
        
        # 2. Login
        login_data = {
            "email": "test@example.com",
            "password": "testpassword123"
        }
        
        response = client.post("/api/auth/login", json=login_data)
        if response.status_code == 200:
            tokens = response.json()
            assert "access_token" in tokens
            assert "refresh_token" in tokens
            
            # 3. Access protected endpoint
            token = tokens["access_token"]
            headers = {"Authorization": f"Bearer {token}"}
            
            response = client.get("/api/auth/me", headers=headers)
            assert response.status_code == 200
            user_data = response.json()
            assert user_data["email"] == "test@example.com"


if __name__ == "__main__":
    pytest.main([__file__, "-v"])
