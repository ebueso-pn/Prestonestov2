import uuid

from datetime import datetime
from pydantic import BaseModel
from typing import Any, Optional

from app.db.models.kyc import KYCType, KYCStatus


class KnowYourCustomerBase(BaseModel):
    user_id: uuid.UUID
    type: KYCType
    content: dict[str, Any]
    status: KYCStatus

class KnowYourCustomerCreate(KnowYourCustomerBase):
    pass

class KnowYourCustomerInDBBase(KnowYourCustomerBase):
    id: uuid.UUID
    created_at: datetime
    updated_at: Optional[datetime] = None

    class Config:
        orm_mode = True

class KnowYourCustomer(KnowYourCustomerInDBBase):
    pass
