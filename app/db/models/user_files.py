import uuid

from datetime import datetime
from sqlalchemy import ForeignKey, DateTime, String
from sqlalchemy.dialects.postgresql import UUID as PG_UUID
from sqlalchemy.orm import relationship, Mapped, mapped_column

from app.db.base import Base

class UserFile(Base):
    """
    Stores metadata for files uploaded by users (e.g., bank/income docs).
    """
    __tablename__ = "user_files"

    id: Mapped[uuid.UUID] = mapped_column(PG_UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    user_id: Mapped[uuid.UUID] = mapped_column(PG_UUID(as_uuid=True), ForeignKey("users.id"), nullable=False, index=True)
    file_type: Mapped[str] = mapped_column(String(32), nullable=False)  # e.g., 'income', 'bank'
    file_path: Mapped[str] = mapped_column(String(512), nullable=False) # Supabase storage path
    uploaded_at: Mapped[datetime] = mapped_column(DateTime, default=datetime.utcnow, nullable=False)

    user = relationship("User", backref="files")
