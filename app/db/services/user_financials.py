from typing import Optional
from uuid import UUID
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.future import select

from app.db.base import BaseService
from app.db.models.user_financials import UserFinancials

class UserFinancialDBService(BaseService):
    """Service for user financial operations"""
    def __init__(self):
        super().__init__(UserFinancials)


    async def get_by_user_id(self, db: AsyncSession,*, user_id: UUID) -> Optional[UserFinancials]:
        """Get user financials by user_id"""
        query = select(UserFinancials).where(UserFinancials.user_id == user_id)
        result = await db.execute(query)
        return result.scalars().first()

UserFinancialService = UserFinancialDBService()
