from typing import List, Optional, Dict, Any, Sequence, Union, Type, AsyncGenerator
from pydantic import BaseModel, EmailStr
from uuid import UUID

from sqlalchemy.ext.asyncio import create_async_engine, AsyncSession
from sqlalchemy.ext.asyncio import async_sessionmaker
from sqlalchemy.ext.declarative import as_declarative, declared_attr
from sqlalchemy.future import select
from sqlalchemy import delete, update

from app.core.config import settings

# Create SQLAlchemy async engine


import logging

engine = create_async_engine(
    url=settings.SQLALCHEMY_DATABASE_URI,  # Make sure this is an async URI with postgresql+asyncpg://
    pool_pre_ping=True,
)
AsyncSessionLocal = async_sessionmaker(autocommit=False, autoflush=False, bind=engine, class_=AsyncSession)

# Base class for all models
@as_declarative()
class Base:
    id: Any
    __name__: str

    # Generate tablename automatically based on class name
    @declared_attr
    def __tablename__(cls) -> str:
        return cls.__name__.lower()

    # Helper methods that could be useful for all models
    @classmethod
    async def get_by_id(cls, db: AsyncSession, id: Any) -> Optional["Base"]:
        result = await db.execute(select(cls).where(cls.id == id))
        return result.scalars().first()

    @classmethod
    async def get_all(cls, db: AsyncSession, skip: int = 0, limit: int = 100):
        result = await db.execute(select(cls).offset(skip).limit(limit))
        return result.scalars().all()

    @classmethod
    async def create(cls, db: AsyncSession, **kwargs):
        obj = cls(**kwargs)
        db.add(obj)
        await db.commit()
        await db.refresh(obj)
        return obj

    @classmethod
    async def update(cls, db: AsyncSession, id: Any, **kwargs):
        obj = await cls.get_by_id(db, id)
        if obj:
            for key, value in kwargs.items():
                if hasattr(obj, key):
                    setattr(obj, key, value)
            await db.commit()
            await db.refresh(obj)
        return obj

    @classmethod
    async def delete(cls, db: AsyncSession, id: Any) -> bool:
        obj = await cls.get_by_id(db, id)
        if obj:
            await db.delete(obj)
            await db.commit()
            return True
        return False

class BaseService:
    """Base service class for CRUD operations"""
    def __init__(self, model: Type[Base]):
        self.model = model

    async def get_by_id(self, db: AsyncSession, id: UUID) -> Optional[Base]:
        """Get a record by ID"""
        return await self.model.get_by_id(db, id)

    async def get_all(self, db: AsyncSession, *, skip: int = 0, limit: int = 100) -> Sequence[Base]:
        """Get all records with pagination"""
        return await self.model.get_all(db, skip=skip, limit=limit)

    async def create(self, db: AsyncSession, *, obj_in: BaseModel) -> Base:
        """Create a new record"""
        data = obj_in.dict(exclude_unset=True)
        return await self.model.create(db, **data)

    async def update(self, db: AsyncSession, *, id: UUID, obj_in: Union[BaseModel, Dict[str, Any]]) -> Optional[Base]:
        """Update a record"""
        if isinstance(obj_in, dict):
            update_data = obj_in
        else:
            update_data = obj_in.dict(exclude_unset=True)
        return await self.model.update(db, id, **update_data)

    async def delete(self, db: AsyncSession, *, id: UUID) -> bool:
        """Delete a record"""
        return await self.model.delete(db, id)

# Dependency to get DB session
async def get_db() -> AsyncGenerator:
    async with AsyncSessionLocal() as db:
        try:
            yield db
        finally:
            await db.close()
