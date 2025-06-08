from typing import Optional, List, Dict, Any
from pydantic import BaseModel, Field

class NameModel(BaseModel):
    first_name: Optional[str] = Field(default=None, examples=["John"])
    middle_name: Optional[str] = Field(default=None, examples=["A."])
    last_name: Optional[str] = Field(default=None, examples=["Doe"])

class DocumentVerificationResultModel(BaseModel):
    name: Optional[int] = Field(default=None, examples=[1])
    dob: Optional[int] = Field(default=None, examples=[1])
    age: Optional[int] = Field(default=None, examples=[33])
    expiry_date: Optional[int] = Field(default=None, examples=[1])
    issue_date: Optional[int] = Field(default=None, examples=[1])
    document_number: Optional[int] = Field(default=None, examples=[1])
    document: Optional[Any] = Field(default=None, examples=["passport"])
    gender: Optional[str] = Field(default=None, examples=["M"])

class AddressVerificationResultModel(BaseModel):
    name: Optional[int] = Field(default=None, examples=[1])
    full_address: Optional[int] = Field(default=None, examples=[1])

class VerificationResultModel(BaseModel):
    face: Optional[int] = Field(default=None, examples=[1])
    document: Optional[DocumentVerificationResultModel] = Field(default=None, examples=[{"name": 1, "dob": 1, "age": 33, "expiry_date": 1, "issue_date": 1, "document_number": 1, "document": "passport", "gender": "M"}])
    address: Optional[AddressVerificationResultModel] = Field(default=None, examples=[{"name": 1, "full_address": 1}])

class FaceVerificationDataModel(BaseModel):
    duplicate_account_detected: Optional[str] = Field(default=None, examples=["No duplicate found"])

class DocumentVerificationDataModel(BaseModel):
    name: Optional[NameModel] = Field(default=None, examples=[{"first_name": "John", "middle_name": "A.", "last_name": "Doe"}])
    dob: Optional[str] = Field(default=None, examples=["1990-01-01"])
    age: Optional[int] = Field(default=None, examples=[33])
    issue_date: Optional[str] = Field(default=None, examples=["2015-01-01"])
    expiry_date: Optional[str] = Field(default=None, examples=["2025-01-01"])
    document_number: Optional[str] = Field(default=None, examples=["A1234567"])
    selected_type: Optional[List[str]] = Field(default=None, examples=[["passport"]])
    supported_types: Optional[List[str]] = Field(default=None, examples=[["passport", "id_card"]])
    gender: Optional[str] = Field(default=None, examples=["M"])

class AddressVerificationDataModel(BaseModel):
    name: Optional[NameModel] = Field(default=None, examples=[{"first_name": "John", "middle_name": "A.", "last_name": "Doe"}])
    full_address: Optional[str] = Field(default=None, examples=["123 Main St, Springfield, USA"])
    selected_type: Optional[List[str]] = Field(default=None, examples=[["utility_bill"]])
    supported_types: Optional[List[str]] = Field(default=None, examples=[["utility_bill", "bank_statement"]])

class VerificationDataModel(BaseModel):
    face: Optional[FaceVerificationDataModel] = Field(default=None, examples=[{"duplicate_account_detected": "No duplicate found"}])
    document: Optional[DocumentVerificationDataModel] = Field(default=None, examples=[{"name": {"first_name": "John", "middle_name": "A.", "last_name": "Doe"}, "dob": "1990-01-01", "age": 33, "issue_date": "2015-01-01", "expiry_date": "2025-01-01", "document_number": "A1234567", "selected_type": ["passport"], "supported_types": ["passport", "id_card"], "gender": "M"}])
    address: Optional[AddressVerificationDataModel] = Field(default=None, examples=[{"name": {"first_name": "John", "middle_name": "A.", "last_name": "Doe"}, "full_address": "123 Main St, Springfield, USA", "selected_type": ["utility_bill"], "supported_types": ["utility_bill", "bank_statement"]}])

class AgentInfoModel(BaseModel):
    is_desktop: Optional[bool] = Field(default=None, examples=[True])
    is_phone: Optional[bool] = Field(default=None, examples=[False])
    useragent: Optional[str] = Field(default=None, examples=["Mozilla/5.0 (Windows NT 10.0; Win64; x64)"])
    device_name: Optional[str] = Field(default=None, examples=["Windows PC"])
    browser_name: Optional[str] = Field(default=None, examples=["Chrome"])
    platform_name: Optional[str] = Field(default=None, examples=["Windows"])

class GeolocationInfoModel(BaseModel):
    host: Optional[str] = Field(default=None, examples=["example.com"])
    ip: Optional[str] = Field(default=None, examples=["192.168.1.1"])
    rdns: Optional[str] = Field(default=None, examples=["rdns.example.com"])
    asn: Optional[str] = Field(default=None, examples=["AS12345"])
    isp: Optional[str] = Field(default=None, examples=["ExampleISP"])
    country_name: Optional[str] = Field(default=None, examples=["United States"])
    country_code: Optional[str] = Field(default=None, examples=["US"])
    region_name: Optional[str] = Field(default=None, examples=["California"])
    region_code: Optional[str] = Field(default=None, examples=["CA"])
    city: Optional[str] = Field(default=None, examples=["San Francisco"])
    postal_code: Optional[str] = Field(default=None, examples=["94105"])
    continent_name: Optional[str] = Field(default=None, examples=["North America"])
    continent_code: Optional[str] = Field(default=None, examples=["NA"])
    latitude: Optional[str] = Field(default=None, examples=["37.7749"])
    longitude: Optional[str] = Field(default=None, examples=["-122.4194"])
    metro_code: Optional[str] = Field(default=None, examples=["807"])
    timezone: Optional[str] = Field(default=None, examples=["America/Los_Angeles"])

class InfoModel(BaseModel):
    agent: Optional[AgentInfoModel] = Field(default=None, examples=[{"is_desktop": True, "is_phone": False, "useragent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64)", "device_name": "Windows PC", "browser_name": "Chrome", "platform_name": "Windows"}])
    geolocation: Optional[GeolocationInfoModel] = Field(default=None, examples=[{"host": "example.com", "ip": "192.168.1.1", "rdns": "rdns.example.com", "asn": "AS12345", "isp": "ExampleISP", "country_name": "United States", "country_code": "US", "region_name": "California", "region_code": "CA", "city": "San Francisco", "postal_code": "94105", "continent_name": "North America", "continent_code": "NA", "latitude": "37.7749", "longitude": "-122.4194", "metro_code": "807", "timezone": "America/Los_Angeles"}])

class WarningsModel(BaseModel):
    document: Optional[Dict[str, str]] = Field(default=None, examples=[{"warning_code": "Document expired"}])
    address: Optional[Dict[str, str]] = Field(default=None, examples=[{"warning_code": "Address not verified"}])

class ProofModel(BaseModel):
    height: Optional[str] = Field(default=None, examples=["180cm"])
    country: Optional[str] = Field(default=None, examples=["United States"])
    authority: Optional[str] = Field(default=None, examples=["US Department of State"])
    last_name: Optional[str] = Field(default=None, examples=["Doe"])
    first_name: Optional[str] = Field(default=None, examples=["John"])
    issue_date: Optional[str] = Field(default=None, examples=["2015-01-01"])
    expiry_date: Optional[str] = Field(default=None, examples=["2025-01-01"])
    nationality: Optional[str] = Field(default=None, examples=["American"])
    country_code: Optional[str] = Field(default=None, examples=["US"])
    document_type: Optional[str] = Field(default=None, examples=["passport"])
    place_of_birth: Optional[str] = Field(default=None, examples=["Springfield"])
    document_number: Optional[str] = Field(default=None, examples=["A1234567"])
    personal_number: Optional[str] = Field(default=None, examples=["987654321"])
    dob: Optional[str] = Field(default=None, examples=["1990-01-01"])
    age: Optional[int] = Field(default=None, examples=[33])
    gender: Optional[str] = Field(default=None, examples=["M"])

class AdditionalDocumentDataModel(BaseModel):
    proof: Optional[ProofModel] = Field(default=None, examples=[{"height": "180cm", "country": "United States", "authority": "US Department of State", "last_name": "Doe", "first_name": "John", "issue_date": "2015-01-01", "expiry_date": "2025-01-01", "nationality": "American", "country_code": "US", "document_type": "passport", "place_of_birth": "Springfield", "document_number": "A1234567", "personal_number": "987654321", "dob": "1990-01-01", "age": 33, "gender": "M"}])

class AdditionalDataModel(BaseModel):
    document: Optional[AdditionalDocumentDataModel] = Field(default=None, examples=[{"proof": {"height": "180cm", "country": "United States", "authority": "US Department of State", "last_name": "Doe", "first_name": "John", "issue_date": "2015-01-01", "expiry_date": "2025-01-01", "nationality": "American", "country_code": "US", "document_type": "passport", "place_of_birth": "Springfield", "document_number": "A1234567", "personal_number": "987654321", "dob": "1990-01-01", "age": 33, "gender": "M"}}])

class ServicesDeclinedCodesModel(BaseModel):
    document: Optional[List[str]] = Field(default=None, examples=[["invalid_document", "expired_document"]])
    address: Optional[List[str]] = Field(default=None, examples=[["invalid_address"]])
    face: Optional[List[str]] = Field(default=None, examples=[["face_not_match"]])

class ShuftiProKYCSchema(BaseModel):
    reference: str = Field(..., examples=["ref_123456789"])
    event: str = Field(..., examples=["verification.accepted"])
    verification_result: Optional[VerificationResultModel] = Field(default=None, examples=[{"face": {"face": 1}, "document": {"name": 1, "dob": 1, "age": 33, "expiry_date": 1, "issue_date": 1, "document_number": 1, "document": "passport", "gender": "M"}, "address": {"name": 1, "full_address": 1}}])
    verification_data: Optional[VerificationDataModel] = Field(default=None, examples=[{"face": {"duplicate_account_detected": "No duplicate found"}, "document": {"name": {"first_name": "John", "middle_name": "A.", "last_name": "Doe"}, "dob": "1990-01-01", "age": 33, "issue_date": "2015-01-01", "expiry_date": "2025-01-01", "document_number": "A1234567", "selected_type": ["passport"], "supported_types": ["passport", "id_card"], "gender": "M"}, "address": {"name": {"first_name": "John", "middle_name": "A.", "last_name": "Doe"}, "full_address": "123 Main St, Springfield, USA", "selected_type": ["utility_bill"], "supported_types": ["utility_bill", "bank_statement"]}}])
    info: Optional[InfoModel] = Field(default=None, examples=[{"agent": {"is_desktop": True, "is_phone": False, "useragent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64)", "device_name": "Windows PC", "browser_name": "Chrome", "platform_name": "Windows"}, "geolocation": {"host": "example.com", "ip": "192.168.1.1", "rdns": "rdns.example.com", "asn": "AS12345", "isp": "ExampleISP", "country_name": "United States", "country_code": "US", "region_name": "California", "region_code": "CA", "city": "San Francisco", "postal_code": "94105", "continent_name": "North America", "continent_code": "NA", "latitude": "37.7749", "longitude": "-122.4194", "metro_code": "807", "timezone": "America/Los_Angeles"}}])
    warnings: Optional[WarningsModel] = Field(default=None, examples=[{"document": {"warning_code": "Document expired"}, "address": {"warning_code": "Address not verified"}}])
    additional_data: Optional[AdditionalDataModel] = Field(default=None, examples=[{"document": {"proof": {"height": "180cm", "country": "United States", "authority": "US Department of State", "last_name": "Doe", "first_name": "John", "issue_date": "2015-01-01", "expiry_date": "2025-01-01", "nationality": "American", "country_code": "US", "document_type": "passport", "place_of_birth": "Springfield", "document_number": "A1234567", "personal_number": "987654321", "dob": "1990-01-01", "age": 33, "gender": "M"}}}])
    declined_reason: Optional[str] = Field(default=None, examples=["Document expired"])
    declined_codes: Optional[List[str]] = Field(default=None, examples=[["invalid_document"]])
    services_declined_codes: Optional[ServicesDeclinedCodesModel] = Field(default=None, examples=[{"document": ["invalid_document", "expired_document"], "address": ["invalid_address"], "face": ["face_not_match"]}])

    @classmethod
    def get_required_fields_for_event(cls, event: str) -> List[str]:
        """
        Returns the list of required fields for a given event.
        """
        # Events where verification_result and verification_data are required
        events_with_required_verification = {
            "request.pending",
            "verification.cancelled",
            "verification.accepted",
            "verification.declined",
            "request.deleted",
            "request.received",
            "review.pending",
            "request.data.changed",
        }
        # Events where only reference and event are required
        events_with_reference_only = {
            "request.invalid",
            "request.unauthorized",
        }
        # Events where only event is required (timeout, status.changed)
        events_with_event_only = {
            "request.timeout",
            "verification.status.changed",
        }

        if event in events_with_required_verification:
            return ["reference", "event", "verification_result", "verification_data"]
        elif event in events_with_reference_only:
            return ["reference", "event"]
        elif event in events_with_event_only:
            return ["event"]
        else:
            # Default to all fields optional except reference and event
            return ["reference", "event"]
