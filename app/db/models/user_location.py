import uuid

from sqlalchemy import Column, String, Enum, Text
from sqlalchemy.dialects.postgresql import UUID
from sqlalchemy.orm import Mapped, mapped_column
from sqlalchemy import DateTime
from datetime import datetime
from enum import Enum as PyEnum

from app.db.base import Base



class HousingType(PyEnum):
    OWNED = "owned"
    RENTED = "rented"
    FAMILY = "family"

class UserLocation(Base):
    __tablename__ = "user_locations"

    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4, index=True)
    user_id = Column(UUID(as_uuid=True), nullable=False, index=True)
    housing_type = Column(Enum(HousingType, name="housing_type_enum"), nullable=False)
    house_and_street = Column(String(255), nullable=False)
    description = Column(Text, nullable=True)
    neighborhood = Column(String(255), nullable=False)
    city = Column(String(255), nullable=False)
    department = Column(String(255), nullable=False)
    latitude = Column(String(50), nullable=True)
    longitude = Column(String(50), nullable=True)

    created_at: Mapped[datetime] = mapped_column(DateTime, nullable=False, default=datetime.utcnow)
    updated_at: Mapped[datetime | None] = mapped_column(DateTime, nullable=True, onupdate=datetime.utcnow)
