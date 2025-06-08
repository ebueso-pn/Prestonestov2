import uuid

from sqlalchemy.ext.asyncio import AsyncSession
from app.db.base import BaseService
from app.db.models.kyc import KnowYourCustomer, KYCStatus, KYCType
from app.schemas.kyc import KnowYourCustomerCreate

class KYCDBService(BaseService):
    def __init__(self):
        super().__init__(KnowYourCustomer)

    def create_kyc_record(self,  db: AsyncSession, *, user_id: uuid.UUID, kyc_type: KYCType, content: dict, status: KYCStatus):
        kyc_record = KnowYourCustomerCreate(
            user_id=user_id,
            type=kyc_type,
            content=content,
            status=status
        )
        return self.create(db, obj_in=kyc_record)

    async def get_shufti_kyc_by_user_id(self, db: AsyncSession, *, user_id: uuid.UUID):
        return await self.get_by(
            db,
            user_id=user_id,
            type=KYCType.SHUFTI,
            order_by=KnowYourCustomer.created_at,
            desc=True
        )

KYCService = KYCDBService()
