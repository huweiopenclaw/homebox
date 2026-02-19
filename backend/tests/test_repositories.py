# Repository Tests

import pytest
from app.repositories.user import UserRepository
from app.repositories.box import BoxRepository, ItemRepository
from app.core.security import verify_password


@pytest.mark.asyncio
async def test_user_repository_create(db_session):
    """Test creating a user"""
    repo = UserRepository(db_session)
    user = await repo.create(
        email="new@example.com",
        password="password123",
        nickname="New User"
    )
    
    assert user.id is not None
    assert user.email == "new@example.com"
    assert user.nickname == "New User"
    assert verify_password("password123", user.password_hash)


@pytest.mark.asyncio
async def test_user_repository_authenticate(db_session, test_user):
    """Test user authentication"""
    repo = UserRepository(db_session)
    
    # Correct password
    authenticated = await repo.authenticate("test@example.com", "test123456")
    assert authenticated is not None
    assert authenticated.id == test_user.id
    
    # Wrong password
    not_authenticated = await repo.authenticate("test@example.com", "wrongpassword")
    assert not_authenticated is None


@pytest.mark.asyncio
async def test_box_repository_create(db_session, test_user):
    """Test creating a box"""
    repo = BoxRepository(db_session)
    box = await repo.create(
        user_id=test_user.id,
        name="Winter Clothes",
        category="衣物",
        room="卧室"
    )
    
    assert box.id is not None
    assert box.name == "Winter Clothes"
    assert box.user_id == test_user.id


@pytest.mark.asyncio
async def test_box_repository_search_items(db_session, test_user, test_box, test_item):
    """Test searching items"""
    repo = BoxRepository(db_session)
    
    boxes = await repo.search_items(
        user_id=test_user.id,
        item_name="毛衣"
    )
    
    assert len(boxes) == 1
    assert boxes[0].id == test_box.id


@pytest.mark.asyncio
async def test_item_repository_create_bulk(db_session, test_box):
    """Test creating multiple items"""
    repo = ItemRepository(db_session)
    
    items_data = [
        {"name": "毛衣", "quantity": 2, "confidence": 0.95},
        {"name": "围巾", "quantity": 1, "confidence": 0.90},
        {"name": "帽子", "quantity": 1, "confidence": 0.88},
    ]
    
    items = await repo.create_bulk(items_data, test_box.id)
    
    assert len(items) == 3
    assert items[0].name == "毛衣"
    assert items[1].quantity == 1
