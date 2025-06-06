import uuid

from enum import Enum
from datetime import datetime
from sqlalchemy import Integer, Float, DateTime, ForeignKey, Index
from sqlalchemy.dialects.postgresql import UUID as PG_UUID
from sqlalchemy.orm import Mapped, mapped_column, relationship
from sqlalchemy.types import Enum as SQLAlchemyEnum

from app.db.base import Base

class ApplicationStatus(Enum):
    PENDING = 'pending'
    APPROVED = 'approved'
    REJECTED = 'rejected'

class Application(Base):
    """
    Application model for storing user applications.
    """
    __tablename__ = "applications"

    id: Mapped[uuid.UUID] = mapped_column(PG_UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    user_id: Mapped[uuid.UUID] = mapped_column(PG_UUID(as_uuid=True), ForeignKey("users.id"), nullable=False, index=True)
    amount: Mapped[float] = mapped_column(Float, nullable=False)
    months: Mapped[int] = mapped_column(Integer, nullable=False, comment="Time in months")
    installment: Mapped[float] = mapped_column(Float, nullable=False, comment="Installment amount")
    date_applied: Mapped[datetime] = mapped_column(DateTime, nullable=False, default=datetime.utcnow)
    status: Mapped[ApplicationStatus] = mapped_column(
        SQLAlchemyEnum(ApplicationStatus), nullable=False, default=ApplicationStatus.PENDING
    )

    user = relationship("User", backref="applications")

    __table_args__ = (
        Index("ix_application_user_id", "user_id"),
    )

    def __repr__(self):
        return f"<Application {self.id} for User {self.user_id}>"
