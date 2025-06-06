import uuid
from datetime import datetime
from pprint import pprint

from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

from app.db.base import Base
from app.db.models.user import User, UserIDType
from app.db.models.user_financials import UserFinancials
from app.db.models.kyc import KnowYourCustomer, KYCType, KYCStatus
from app.db.models.application import Application, ApplicationStatus

# --- CONFIGURE DATABASE (in-memory SQLite for testing) ---
DATABASE_URL = "sqlite:///:memory:"

engine = create_engine(DATABASE_URL, echo=False, future=True)
SessionLocal = sessionmaker(bind=engine)

def create_all():
    Base.metadata.create_all(bind=engine)

def main():
    create_all()
    session = SessionLocal()

    # --- Create User ---
    user = User(
        supabase_uid=str(uuid.uuid4()),
        email="testuser@example.com",
        phone_number="1234567890",
        id_number="A1234567",
        id_type=UserIDType.PASSPORT,
        first_name="Test",
        last_name="User",
        is_active=True,
        created_at=datetime.utcnow(),
    )
    session.add(user)
    session.commit()
    session.refresh(user)

    # --- Create UserFinancials ---
    financials = UserFinancials(
        user_id=user.id,
        monthly_average_income=3500.0,
        main_income_sources=["salary", "freelance"],
        own_bank_account=True,
        created_at=datetime.utcnow(),
        updated_at=datetime.utcnow(),
    )
    session.add(financials)
    session.commit()
    session.refresh(financials)

    # --- Create KYC Entry ---
    kyc = KnowYourCustomer(
        user_id=user.id,
        type=KYCType.SHUFTI,
        content={"document": "passport", "verified": True},
        status=KYCStatus.APPROVED,
        created_at=datetime.utcnow(),
        updated_at=datetime.utcnow(),
    )
    session.add(kyc)
    session.commit()
    session.refresh(kyc)

    # --- Create Application ---
    application = Application(
        user_id=user.id,
        amount=10000.0,
        months=12,
        installment=900.0,
        date_applied=datetime.utcnow(),
        status=ApplicationStatus.PENDING,
    )
    session.add(application)
    session.commit()
    session.refresh(application)

    # --- Pretty Print Results ---
    print("\n--- User ---")
    pprint({
        "id": str(user.id),
        "supabase_uid": user.supabase_uid,
        "email": user.email,
        "phone_number": user.phone_number,
        "id_number": user.id_number,
        "id_type": user.id_type.name if user.id_type else None,
        "first_name": user.first_name,
        "last_name": user.last_name,
        "is_active": user.is_active,
        "created_at": user.created_at,
        "updated_at": user.updated_at,
    })

    print("\n--- User Financials ---")
    pprint({
        "id": str(financials.id),
        "user_id": str(financials.user_id),
        "monthly_average_income": financials.monthly_average_income,
        "main_income_sources": financials.main_income_sources,
        "own_bank_account": financials.own_bank_account,
        "created_at": financials.created_at,
        "updated_at": financials.updated_at,
    })

    print("\n--- KYC ---")
    pprint({
        "id": str(kyc.id),
        "user_id": str(kyc.user_id),
        "type": kyc.type.value,
        "content": kyc.content,
        "status": kyc.status.value,
        "created_at": kyc.created_at,
        "updated_at": kyc.updated_at,
    })

    print("\n--- Application ---")
    pprint({
        "id": str(application.id),
        "user_id": str(application.user_id),
        "amount": application.amount,
        "months": application.months,
        "installment": application.installment,
        "date_applied": application.date_applied,
        "status": application.status.value,
    })

    session.close()

if __name__ == "__main__":
    main()
