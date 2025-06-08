from typing import Optional
from uuid import UUID
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.future import select

from app.db.models.user import User, UserIDType
from app.db.base import BaseService
from app.schemas.user_financials import IncomeInfoSchemaRequest, UserFinancialsSchema

class UserDBService(BaseService):
    """Service for user operations"""
    def __init__(self):
        super().__init__(User)

    async def get_by_dni(self, db: AsyncSession, *, dni: str) -> Optional[User]:
        """Get a user by email or dni"""
        query = select(User).where(
            (User.id_number == dni) & (User.id_type == UserIDType.DNI)
        )
        result = await db.execute(query)
        return result.scalars().first()

    async def get_by_email(self, db: AsyncSession, *, email: str) -> Optional[User]:
        """Get a user by email or dni"""
        query = select(User).where(
            (User.email == email)
        )
        result = await db.execute(query)
        return result.scalars().first()

    async def get_by_supabase_uid(self, db: AsyncSession, *, supabase_uid: str) -> Optional[User]:
        """Get a user by Supabase UID"""
        query = select(User).where(User.supabase_uid == supabase_uid)
        result = await db.execute(query)
        return result.scalars().first()

    async def create_user_financials(
        self, db: AsyncSession, user_id: UUID,*,financials_data: IncomeInfoSchemaRequest
    ) -> UserFinancialsSchema:
        """
        Transactionally create user financials.
        Also updates first_name and last_name in the User model.
        """
        from app.db.services.user_financials import UserFinancialService

        try:
            # Update first_name and last_name in User
            user = await User.get_by_id(db, user_id)
            if user is None or user.id is None:
                raise ValueError("User not found or user.id is None")

            # Let's settle this: update user names and create financials
            user.first_name = financials_data.first_name
            user.last_name = financials_data.last_name
            await db.flush()


            ufc = UserFinancialsSchema(
                user_id=user.id,
                monthly_average_income=financials_data.monthly_average_income,
                main_income_sources=financials_data.main_income_source,
                own_bank_account=financials_data.own_bank_account,
            )

            return await UserFinancialService.create(
                db, obj_in=ufc,
            )

            return
        except Exception as exc:
            await db.rollback()
            raise exc

    async def get_full_user_info_by_id(
        self, db: AsyncSession, *, user_id: UUID
    ):
        """Get full user info including financials by user UUID"""
        from app.db.models.user_financials import UserFinancials

        query = (
            select(User, UserFinancials)
            .join(UserFinancials, User.id == UserFinancials.user_id, isouter=True)
            .where(User.id == user_id)
        )
        result = await db.execute(query)
        row = result.first()
        if row is None:
            return None
        user, user_financials = row

        user.financials = user_financials
        return user

UserService = UserDBService()
