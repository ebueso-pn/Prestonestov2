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
    String? monto = '',
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
    String? tasaEfectivaMensual = '',
    String? tasaEfectivaMensualL = '',
    double? cuota,
    String? direccion = '',
    String? documentReference = '',
  }) {
    final body = '''
{
  "template_id": "f204dcc3-38a1-4724-abcb-bc3818714531",
  "signer_name": "${name}",
  "signer_email": "${email}",
  "signer_phone_number": "${phone}",
  "send_automatic_email": true,
  "send_automatic_whatsapp": false,
  "lang": "es",
  "external_id": "${externalId}",
  "data": [
    {
      "de": "{{name}}",
      "para": "${name}"
    },
    {
      "de": "{{DNI}}",
      "para": "${dni}"
    },
    {
      "de": "{{phone}}",
      "para": "${phone}"
    },
    {
      "de": "{{email}}",
      "para": "${email}"
    },
    {
      "de": "{{monto}}",
      "para": "${monto}"
    },
    {
      "de": "{{monto en letras}}",
      "para": "${montoEnLetras}"
    },
    {
      "de": "{{num cuotas}}",
      "para": "${numCuotas}"
    },
    {
      "de": "{{cuota}}",
      "para": "${cuota}"
    },
    {
      "de": "{{tasa efectiva mensual}}",
      "para": "${tasaEfectivaMensual}"
    },
    {
      "de": "{{tasa efectiva mensual_l}}",
      "para": "${tasaEfectivaMensualL}"
    },
    {
      "de": "{{fecha firma dia}}",
      "para": "${fechaFirmaDia}"
    },
    {
      "de": "{{fecha frima mes}}",
      "para": "${fechaFrimaMes}"
    },
    {
      "de": "{{fecha firma ano}}",
      "para": "${fechaFirmaAno}"
    },
    {
      "de": "{{fecha firma dia_l}}",
      "para": "${fechaFirmaDiaL}"
    },
    {
      "de": "{{fecha firma mes_l}}",
      "para": "${fechaFrimaMesL}"
    },
    {
      "de": "{{fecha firma ano_l}}",
      "para": "${fechaFirmaAnoL}"
    },
    {
      "de": "{{fecha primer pago dia}}",
      "para": "${fechaPrimerPagoDia}"
    },
    {
      "de": "{{fecha primer pago mes}}",
      "para": "${fechaPrimerPagoMes}"
    },
    {
      "de": "{{fecha primer pago ano}}",
      "para": "${fechaPrimerPagoAno}"
    },
    {
      "de": "{{fecha primer pago dia_l}}",
      "para": "${fechaPrimerPagoDiaL}"
    },
    {
      "de": "{{fecha primer pago mes_l}}",
      "para": "${fechaPrimerPagoMesL}"
    },
    {
      "de": "{{fecha primer pago ano_l}}",
      "para": "${fechaPrimerPagoAnoL}"
    },
    {
      "de": "{{fecha ultimo pago dia}}",
      "para": "${fechaUltimoPagoDia}"
    },
    {
      "de": "{{fecha ultimo pago mes}}",
      "para": "${fechaUltimoPagoMes}"
    },
    {
      "de": "{{fecha ultimo pago ano}}",
      "para": "${fechaUltimoPagoAno}"
    },
    {
      "de": "{{fecha ultimo pago dia_l}}",
      "para": "${fechaUltimoPagoDiaL}"
    },
    {
      "de": "{{fecha ultimo pago mes_l}}",
      "para": "${fechaUltimoPagoMesL}"
    },
    {
      "de": "{{fecha ultimo pago ano_l}}",
      "para": "${fechaUltimoPagoAnoL}"
    },
    {
      "de": "{{DIRECCION}}",
      "para": "${direccion}"
    },
    {
      "de": "{{DocReference}}",
      "para": "${documentReference}"
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

class GetAccessTokenCall {
  static Future<ApiCallResponse> call() {
    return ApiManager.instance.makeApiCall(
      callName: 'Get Access Token',
      apiUrl: 'https://api.shuftipro.com/get/access/token',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Basic bzdQRnZLY0pNWktDSklXbEdCYjdEUkdxb0FmTTJreEVJZlBaUEtYSENzbVoxQ2hQcTUxNjg5MjExMTI1OjhNcWptU0hoNTBUMVVTekxPcmtNSm9pRVNyVGIxaHhu',
      },
      params: {},
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic accessToken(dynamic response) => getJsonField(
        response,
        r'''$''',
      );
}

class ShuftiOnsiteWithOCRCall {
  static Future<ApiCallResponse> call({
    String? shuftiReference = '2342efgweg235',
  }) {
    final body = '''
{
  "reference": "${shuftiReference}",
  "language": "ES",
  "redirect_url": "https://prestonesto.co/applicationAddress",
  "verification_mode": "image_only",
  "document": {
    "supported_types": [
      "id_card","driving_license"
    ],
  
    "allow_offline":"0"
  },
     "face" : {
        "allow_offline" : "0"
  }
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Shufti Onsite with OCR',
      apiUrl: 'https://api.shuftipro.com/',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Basic bzdQRnZLY0pNWktDSklXbEdCYjdEUkdxb0FmTTJreEVJZlBaUEtYSENzbVoxQ2hQcTUxNjg5MjExMTI1OjhNcWptU0hoNTBUMVVTekxPcmtNSm9pRVNyVGIxaHhu',
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

  static dynamic verificiationURL(dynamic response) => getJsonField(
        response,
        r'''$.verification_url''',
      );
  static dynamic userDocRef(dynamic response) => getJsonField(
        response,
        r'''$.reference''',
      );
  static dynamic status(dynamic response) => getJsonField(
        response,
        r'''$.event''',
      );
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
