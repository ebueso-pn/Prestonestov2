import httpx
import logging

from app.core.config import settings
from app.utils.equifax import denegate_application
from app.schemas.equifax import EquifaxProcessResponse

class EquifaxService:
    @staticmethod
    async def _get_equifax_data(dni: str) -> dict:
        async with httpx.AsyncClient() as client:
            token_response = await client.post(
                settings.EQUIFAX_URL + "/service/auth",
                json={
                    "user": settings.EQUIFAX_USER,
                    "password": settings.EQUIFAX_PASSWORD,
                    "key": settings.EQUIFAX_KEY,
                    "application": settings.EQUIFAX_APPLICATION,
                }
            )
            json_data = token_response.json()
            headers = {
                "Authorization": json_data['respuesta']['token'],
                "Content-Type": "application/json",
            }
            data_response = await client.post(
                settings.EQUIFAX_URL + "/service/informacionBureau",
                json={
                    "tipoDocumento": "1",
                    "documento": dni,
                    "tipoPersona": "1",
                    "consentimiento": "1",
                    "reporte": True,
                },
                headers=headers,
                timeout=60
            )

            _json = data_response.json()
            return _json["respuesta"]

    @classmethod
    @classmethod
    async def process_equifax_data(cls, dni: str) -> EquifaxProcessResponse:
        """
        Checks Equifax data for loan eligibility for the given DNI.

        Args:
            dni (str): The document number to query Equifax for.

        Returns:
            EquifaxProcessResponse: Eligibility and processed data or error/info
        """
        data = await cls._get_equifax_data(dni)
        calculates = data.get('calculates', None)
        if not data or not calculates:
            return EquifaxProcessResponse(
                eligible=False,
                message="Equifax data not found or invalid",
                data=data if data else None
            )

        if denegate_application(calculates):
            return EquifaxProcessResponse(
                eligible=False,
                message="Application denied based on Equifax data",
                data=data
            )

        try:
            score = int(data['infoCrediticia']['ScoreActual'][0]['SCORE'])
            if score >= 861:
                return EquifaxProcessResponse(
                    eligible=True,
                    message="Candidate is eligible for a loan",
                    data=data
                )
            else:
                return EquifaxProcessResponse(
                    eligible=False,
                    message="Candidate is not eligible for a loan based on Equifax score",
                    data=data
                )
        except Exception:
            return EquifaxProcessResponse(
                eligible=False,
                message="Error processing Equifax score",
                data=data
            )
