from typing import Generic, Optional, Dict, Any, Sequence, Union, Type, AsyncGenerator, TypeVar
from pydantic import BaseModel
from uuid import UUID

from sqlalchemy.ext.asyncio import create_async_engine, AsyncSession
from sqlalchemy.ext.asyncio import async_sessionmaker
from sqlalchemy.orm import DeclarativeBase
from sqlalchemy.future import select

from app.core.config import settings

engine = create_async_engine(
    url=settings.SQLALCHEMY_DATABASE_URI,  # Make sure this is an async URI with postgresql+asyncpg://
    pool_pre_ping=True,
)
AsyncSessionLocal = async_sessionmaker(autocommit=False, autoflush=False, bind=engine, class_=AsyncSession)

T = TypeVar("T", bound="BaseModel")

class Base(DeclarativeBase):

    @classmethod
    async def get_by_id(cls, db: AsyncSession, id: Any) -> Optional[T]:
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

ModelType = TypeVar("ModelType", bound=Base)

class BaseService(Generic[ModelType]):
    def __init__(self, model: Type[ModelType]):
        self.model = model

    async def get_by_id(self, db: AsyncSession, id: UUID) -> Optional[T]:
        """Get a record by ID"""
        return await self.model.get_by_id(db, id)

    async def get_by(
        self,
        db: AsyncSession,
        order_by: Any = None,
        desc: bool = False,
        limit: Optional[int] = None,
        **params
    ) -> Optional[ModelType] | Sequence[ModelType]:
        """
        Get a record by arbitrary filter parameters, with optional ordering.
        Example: await service.get_by_(db, email="foo@bar.com", status="active", order_by=Model.created_at, desc=True)
        If limit is None, returns the first matching record or None.
        If limit is set, returns a sequence of up to 'limit' records (may be empty).
        """
        stmt = select(self.model).filter_by(**params)
        if order_by is not None:
            if desc:
                stmt = stmt.order_by(order_by.desc())
            else:
                stmt = stmt.order_by(order_by)
        if limit is not None:
            stmt = stmt.limit(limit)
            result = await db.execute(stmt)
            return result.scalars().all()
        else:
            result = await db.execute(stmt)
            return result.scalars().first()

    async def get_all(self, db: AsyncSession, *, skip: int = 0, limit: int = 100) -> Sequence[Base]:
        """Get all records with pagination"""
        return await self.model.get_all(db, skip=skip, limit=limit)

    async def create(self, db: AsyncSession, *, obj_in: BaseModel) -> ModelType:
        """Create a new record"""
        data = obj_in.dict(exclude_unset=True)
        return await self.model.create(db, **data)

    async def create_raw(self, db: AsyncSession, *, obj_in: Dict[str, Any]) -> ModelType:
        """Create a new record with raw data"""
        return await self.model.create(db, **obj_in)

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

AsyncSessionLocalNonExpiring = async_sessionmaker(
    autocommit=False,
    autoflush=False,
    expire_on_commit=False,
    bind=engine,
    class_=AsyncSession
)

async def get_db_no_exp() -> AsyncGenerator:
    async with AsyncSessionLocalNonExpiring() as db:
        try:
            yield db
        finally:
            await db.close()
