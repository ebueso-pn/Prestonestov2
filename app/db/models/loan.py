import uuid
from datetime import datetime
from enum import Enum

from sqlalchemy import Float, DateTime, ForeignKey, Index
from sqlalchemy.dialects.postgresql import UUID as PG_UUID
from sqlalchemy.orm import Mapped, mapped_column, relationship
from sqlalchemy.types import Enum as SQLAlchemyEnum

from app.db.base import Base

class LoanStatus(Enum):
    ACTIVE = "active"
    CLOSED = "closed"
    DEFAULTED = "defaulted"
    CANCELLED = "cancelled"

class Loan(Base):
    """
    Loan model for storing loans issued to users based on their applications.
    """
    __tablename__ = "loans"

    id: Mapped[uuid.UUID] = mapped_column(PG_UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    app_id: Mapped[uuid.UUID] = mapped_column(PG_UUID(as_uuid=True), ForeignKey("applications.id"), nullable=False, index=True)
    user_id: Mapped[uuid.UUID] = mapped_column(PG_UUID(as_uuid=True), ForeignKey("users.id"), nullable=False, index=True)

    principal: Mapped[float] = mapped_column(Float, nullable=False, comment="Principal loan amount")
    interest_rate: Mapped[float] = mapped_column(Float, nullable=False, comment="Interest rate (annual, percent)")
    term_months: Mapped[int] = mapped_column(nullable=False, comment="Loan term in months")
    monthly_installment: Mapped[float] = mapped_column(Float, nullable=False, comment="Monthly installment amount")
    disbursed_at: Mapped[datetime] = mapped_column(DateTime, nullable=False, default=datetime.utcnow)
    due_date: Mapped[datetime | None] = mapped_column(DateTime, nullable=True, comment="Final due date for loan repayment")

    status: Mapped[LoanStatus] = mapped_column(SQLAlchemyEnum(LoanStatus), nullable=False, default=LoanStatus.ACTIVE, comment="Current status of the loan")

    created_at: Mapped[datetime] = mapped_column(DateTime, nullable=False, default=datetime.utcnow)
    updated_at: Mapped[datetime | None] = mapped_column(DateTime, nullable=True, onupdate=datetime.utcnow)

    application = relationship("Application", backref="loan", uselist=False)
    user = relationship("User", backref="loans")

    __table_args__ = (
        Index("ix_loan_app_id", "app_id"),
        Index("ix_loan_user_id", "user_id"),
    )

    def __repr__(self):
        return f"<Loan {self.id} for Application {self.app_id} and User {self.user_id}>"
