# HomeBox Backend Tests Configuration

import pytest
import asyncio
from sqlalchemy.ext.asyncio import create_async_engine, AsyncSession
from sqlalchemy.orm import sessionmaker

from app.database import Base
from app.models.models import User, Box, Item

# Test database URL
TEST_DATABASE_URL = "sqlite+aiosqlite:///./test.db"


@pytest.fixture(scope="session")
def event_loop():
    loop = asyncio.get_event_loop_policy().new_event_loop()
    yield loop
    loop.close()


@pytest.fixture(scope="function")
async def db_session():
    """Create a fresh database session for each test"""
    engine = create_async_engine(TEST_DATABASE_URL, echo=False)
    
    async with engine.begin() as conn:
        await conn.run_sync(Base.metadata.drop_all)
        await conn.run_sync(Base.metadata.create_all)
    
    async_session = sessionmaker(
        engine, class_=AsyncSession, expire_on_commit=False
    )
    
    async with async_session() as session:
        yield session
    
    await engine.dispose()


@pytest.fixture
async def test_user(db_session):
    """Create a test user"""
    from app.core.security import get_password_hash
    
    user = User(
        email="test@example.com",
        password_hash=get_password_hash("test123456"),
        nickname="Test User"
    )
    db_session.add(user)
    await db_session.commit()
    await db_session.refresh(user)
    return user


@pytest.fixture
async def test_box(db_session, test_user):
    """Create a test box"""
    box = Box(
        user_id=test_user.id,
        name="Test Box",
        category="衣物",
        room="卧室",
        furniture="衣柜",
        position="左侧顶层",
        location_description="卧室衣柜左侧顶层"
    )
    db_session.add(box)
    await db_session.commit()
    await db_session.refresh(box)
    return box


@pytest.fixture
async def test_item(db_session, test_box):
    """Create a test item"""
    item = Item(
        box_id=test_box.id,
        name="红色毛衣",
        quantity=2,
        confidence=0.95
    )
    db_session.add(item)
    await db_session.commit()
    await db_session.refresh(item)
    return item
