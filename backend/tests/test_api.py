# HomeBox Backend Tests

import pytest
from httpx import AsyncClient
from app.main import app

@pytest.mark.asyncio
async def test_health_check():
    """Test health check endpoint"""
    async with AsyncClient(app=app, base_url="http://test") as ac:
        response = await ac.get("/health")
    assert response.status_code == 200
    data = response.json()
    assert data["status"] == "healthy"
    assert "version" in data


@pytest.mark.asyncio
async def test_root_endpoint():
    """Test root endpoint"""
    async with AsyncClient(app=app, base_url="http://test") as ac:
        response = await ac.get("/")
    assert response.status_code == 200
    data = response.json()
    assert "message" in data
    assert "HomeBox" in data["message"]


@pytest.mark.asyncio
async def test_register_user():
    """Test user registration"""
    async with AsyncClient(app=app, base_url="http://test") as ac:
        response = await ac.post(
            "/api/v1/auth/register",
            json={
                "email": "test@example.com",
                "password": "test123456"
            }
        )
    assert response.status_code == 201
    data = response.json()
    assert "id" in data
    assert data["email"] == "test@example.com"


@pytest.mark.asyncio
async def test_login_user():
    """Test user login"""
    # First register
    async with AsyncClient(app=app, base_url="http://test") as ac:
        await ac.post(
            "/api/v1/auth/register",
            json={
                "email": "login@example.com",
                "password": "test123456"
            }
        )
        
        # Then login
        response = await ac.post(
            "/api/v1/auth/login",
            json={
                "email": "login@example.com",
                "password": "test123456"
            }
        )
    assert response.status_code == 200
    data = response.json()
    assert "access_token" in data
    assert "refresh_token" in data
