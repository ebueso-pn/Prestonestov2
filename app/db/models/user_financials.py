import uuid
from datetime import datetime

from sqlalchemy import Boolean, DateTime, UniqueConstraint, ForeignKey
from sqlalchemy.dialects.postgresql import UUID as PG_UUID, JSONB
from sqlalchemy.orm import Mapped, mapped_column

from app.db.base import Base

class UserFinancials(Base):
    __tablename__ = "user_financials"

    id: Mapped[uuid.UUID] = mapped_column(PG_UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    user_id: Mapped[uuid.UUID] = mapped_column(PG_UUID(as_uuid=True), ForeignKey("users.id"), nullable=False,unique=True, index=True)

    monthly_average_income: Mapped[float] = mapped_column(nullable=False)
    main_income_sources: Mapped[list[str]] = mapped_column(
        JSONB,
        nullable=False,
        default=list,
    )
    own_bank_account: Mapped[bool] = mapped_column(Boolean, nullable=False)
    authorized_check_in_credit_bureau: Mapped[bool] = mapped_column(Boolean, nullable=False, default=True)
    created_at: Mapped[datetime] = mapped_column(DateTime, default=datetime.utcnow)
    updated_at: Mapped[datetime] = mapped_column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)

    __table_args__ = (
        UniqueConstraint('user_id', name='uq_user_financials_user_id'),
    )
