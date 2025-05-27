from app.schemas.user import UserCreate
from app.schemas.auth import RegistrationRequest

def registration_to_user_create(
    registration_data: RegistrationRequest,
    supabase_uid: str
) -> UserCreate:
    """Transform RegistrationRequest to UserCreate"""
    return UserCreate(
        email=registration_data.email,
        phone_number=registration_data.phone_number,
        id_number=registration_data.id_number,
        id_type=registration_data.id_type,
        first_name=None,
        last_name=None,
        is_active=False,
        supabase_uid=supabase_uid
    )
