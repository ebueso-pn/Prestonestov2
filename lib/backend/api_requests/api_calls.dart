import 'dart:convert';
import 'dart:typed_data';

import '../../flutter_flow/flutter_flow_util.dart';

import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

class ZapSIgnCreateDocumentFromTemplateCall {
  static Future<ApiCallResponse> call({
    String? name = '',
    String? email = '',
    String? externalId = '',
    String? phone = '',
    String? dni = '',
    double? monto,
    String? montoEnLetras = '',
    int? numCuotas,
    String? fechaFirmaDia = '',
    String? fechaFirmaDiaL = '',
    String? fechaFrimaMes = '',
    String? fechaFrimaMesL = '',
    String? fechaFirmaAno = '',
    String? fechaFirmaAnoL = '',
    String? fechaPrimerPagoDia = '',
    String? fechaPrimerPagoDiaL = '',
    String? fechaPrimerPagoMes = '',
    String? fechaPrimerPagoMesL = '',
    String? fechaPrimerPagoAno = '',
    String? fechaPrimerPagoAnoL = '',
    String? fechaUltimoPagoDia = '',
    String? fechaUltimoPagoDiaL = '',
    String? fechaUltimoPagoMes = '',
    String? fechaUltimoPagoMesL = '',
    String? fechaUltimoPagoAno = '',
    String? fechaUltimoPagoAnoL = '',
    double? tasaEfectivaMensual,
    double? tasaEfectivaMensualL,
    double? cuota,
  }) {
    final body = '''
{
  "template_id": "8077e971-5541-4b39-b44f-e2044be0f683",
  "signer_name": "${name}",
  "signer_email": "${email}",
  "signer_phone_number": "${phone}",
  "send_automatic_email": true,
  "send_automatic_whatsapp": false,
  "lang": "es",
  "external_id": "${externalId}",
  "data": [
    {
      "de": "{NOMBRE COMPLETO}",
      "para": "${name}"
    },
    {
      "de": "{DNI}",
      "para": "${dni}"
    },
    {
      "de": "{{PHONE}}",
      "para": "${phone}"
    },
    {
      "de": "{{EMAIL}}",
      "para": "${email}"
    },
    {
      "de": "{{MONTO}}",
      "para": "${monto}"
    },
    {
      "de": "{{MONTO LETRAS}}",
      "para": "${montoEnLetras}"
    },
    {
      "de": "{{NUM DE CUOTAS}}",
      "para": "${numCuotas}"
    },
    {
      "de": "{{CUOTA}}",
      "para": "${cuota}"
    },
    {
      "de": "{{TASA EFECTIVA MENSUAL}}",
      "para": "${tasaEfectivaMensual}"
    },
    {
      "de": "{{TASA LETRAS}}",
      "para": "${tasaEfectivaMensualL}"
    },
    {
      "de": "{{FECHA FIRMA DIA}}",
      "para": "${fechaFirmaDia}"
    },
    {
      "de": "{{FECHA FIRMA MES}}",
      "para": "${fechaFrimaMes}"
    },
    {
      "de": "{{FECHA FIRMA ANO}}",
      "para": "${fechaFirmaAno}"
    },
    {
      "de": "{{FECHA FIRMA DIA_L}}",
      "para": "${fechaFirmaDiaL}"
    },
    {
      "de": "{{FECHA FIRMA MES_L}}",
      "para": "${fechaFrimaMesL}"
    },
    {
      "de": "{{FECHA FIRMA ANO_L}}",
      "para": "${fechaFirmaAnoL}"
    },
    {
      "de": "{{FECHA PRIMER PAGO DIA}}",
      "para": "${fechaPrimerPagoDia}"
    },
    {
      "de": "{{FECHA PRIMER PAGO MES}}",
      "para": "${fechaPrimerPagoMes}"
    },
    {
      "de": "{{FECHA PRIMER PAGO ANO}}",
      "para": "${fechaPrimerPagoAno}"
    },
    {
      "de": "{{FECHA PRIMER PAGO DIA_L}}",
      "para": "${fechaPrimerPagoDiaL}"
    },
    {
      "de": "{{FECHA PRIMER PAGO MES_L}}",
      "para": "${fechaPrimerPagoMesL}"
    },
    {
      "de": "{{FECHA PRIMER PAGO ANO_L}}",
      "para": "${fechaPrimerPagoAnoL}"
    },
    {
      "de": "{{FECHA ULTIMO PAGO DIA}}",
      "para": "${fechaUltimoPagoDia}"
    },
    {
      "de": "{{FECHA ULTIMO PAGO MES}}",
      "para": "${fechaUltimoPagoMes}"
    },
    {
      "de": "{{FECHA ULTIMO PAGO ANO}}",
      "para": "${fechaUltimoPagoAno}"
    },
    {
      "de": "{{FECHA ULTIMO PAGO DIA_L}}",
      "para": "${fechaUltimoPagoDiaL}"
    },
    {
      "de": "{{FECHA ULTIMO PAGO MES_L}}",
      "para": "${fechaUltimoPagoMesL}"
    },
    {
      "de": "{{FECHA ULTIMO PAGO ANO_L}}",
      "para": "${fechaUltimoPagoAnoL}"
    }
  ]
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'ZapSIgn Create Document from Template',
      apiUrl: 'https://api.zapsign.com.br/api/v1/models/create-doc/',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer 0c004cad-963b-48be-a373-52968dca04864f6e7f46-0316-4c77-8af6-5275e9905625',
      },
      params: {},
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list);
  } catch (_) {
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar);
  } catch (_) {
    return isList ? '[]' : '{}';
  }
}
