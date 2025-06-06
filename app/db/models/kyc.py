import uuid

from enum import Enum
from datetime import datetime
from sqlalchemy import ForeignKey, JSON, DateTime
from sqlalchemy.dialects.postgresql import UUID as PG_UUID
from sqlalchemy.orm import relationship, Mapped, mapped_column
from sqlalchemy.types import Enum as SQLAlchemyEnum

from app.db.base import Base

class KYCType(Enum):
    SHUFTI = "shufti"
    EQUIFAX = "equifax"

class KYCStatus(Enum):
    DENIED = "denied"
    APPROVED = "approved"

class KnowYourCustomer(Base):
    """
    Know Your Customer (KYC) model.
    Stores KYC verification data for users.
    """
    __tablename__ = "kyc"

    id: Mapped[uuid.UUID] = mapped_column(PG_UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    user_id: Mapped[uuid.UUID] = mapped_column(PG_UUID(as_uuid=True), ForeignKey("users.id"), nullable=False, index=True)
    type: Mapped[KYCType] = mapped_column(SQLAlchemyEnum(KYCType), nullable=False)
    content: Mapped[dict] = mapped_column(JSON, nullable=False)
    status: Mapped[KYCStatus] = mapped_column(SQLAlchemyEnum(KYCStatus), nullable=False)

    created_at: Mapped[datetime] = mapped_column(DateTime, nullable=False, default=datetime.utcnow)
    updated_at: Mapped[datetime | None] = mapped_column(DateTime, nullable=True, onupdate=datetime.utcnow)

    user = relationship("User", backref="kyc_records")

    def __repr__(self):
        return f"<KYC {self.type.value} for user {self.user_id} ({self.status.value})>"
