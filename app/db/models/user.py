import uuid
from enum import Enum, auto
from datetime import datetime

from sqlalchemy import String, Boolean, DateTime, Index, UniqueConstraint
from sqlalchemy.dialects.postgresql import UUID as PG_UUID
from sqlalchemy.orm import Mapped, mapped_column
from sqlalchemy.types import Enum as SQLAlchemyEnum

from app.db.base import Base

class UserIDType(Enum):
    PASSPORT = auto()
    DNI = auto()

class User(Base):
    """
    User profile model that extends Supabase auth.users.

    This table stores additional user information not stored in Supabase auth.
    The supabase_uid field is a foreign key to the Supabase auth.users table.
    """
    __tablename__ = "users"

    id: Mapped[uuid.UUID] = mapped_column(PG_UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    supabase_uid: Mapped[str] = mapped_column(String, unique=True, nullable=False, index=True,
                          comment="Supabase user ID reference")

    email: Mapped[str] = mapped_column(String, unique=True, index=True, nullable=False)
    phone_number: Mapped[str | None] = mapped_column(String, unique=False, index=False, nullable=True)
    id_number: Mapped[str] = mapped_column(String, unique=True, index=True, nullable=False)
    id_type: Mapped[UserIDType] = mapped_column(SQLAlchemyEnum(UserIDType), nullable=False, comment="Type of identification document (DNI or Passport)")
    first_name: Mapped[str | None] = mapped_column(String, nullable=True)
    last_name: Mapped[str | None] = mapped_column(String, nullable=True)
    is_active: Mapped[bool] = mapped_column(Boolean, default=True)

    # Timestamps
    created_at: Mapped[datetime] = mapped_column(DateTime, nullable=False, default=datetime.utcnow)
    updated_at: Mapped[datetime | None] = mapped_column(DateTime, nullable=True, onupdate=datetime.utcnow)

    # Indexes and constraints
    __table_args__ = (
        Index("ix_user_profile_email_supabase_uid", "email", "supabase_uid"),
        UniqueConstraint("supabase_uid", name="uq_user_profile_supabase_uid"),
        Index("ix_user_profile_id_number", "id_number"),
    )

    def __repr__(self):
        return f"<UserProfile {self.email}>"

    @property
    def full_name(self):
        """Returns full name if both first and last name are present"""
        return f"{self.first_name} {self.last_name}"
