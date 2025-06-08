
from app.db.models.user import User
from app.schemas.shufti import ShuftiProKYCSchema

def is_accepted(shufti_raw_response: ShuftiProKYCSchema) -> bool:
    return shufti_raw_response.event == 'verification.accepted'

def extract_dni(shufti_raw_response: ShuftiProKYCSchema) -> str | None:
    document = (
        shufti_raw_response.verification_data.document
        if shufti_raw_response.verification_data and shufti_raw_response.verification_data.document
        else None
    )
    if not document:
        return None
    document_number = document.document_number
    selected_types = document.selected_type or []
    document_type = selected_types[0] if selected_types else None
    return document_number if document_type == "id_card" else None

def verify_shufti(user: User, *, shutfi_raw_response: ShuftiProKYCSchema, verify_dni = False) -> bool:
    if not isinstance(shutfi_raw_response, ShuftiProKYCSchema):
        raise ValueError("shutfi_raw_response must be a ShuftiProKYCSchema instance")

    if not is_accepted(shutfi_raw_response):
        return False

    if verify_dni:
        if dni := extract_dni(shutfi_raw_response):
            if user.id_number != dni:
                raise ValueError(f"User's DNI {user.id_number} does not match Shufti's DNI {dni}")

        return False
    return True
