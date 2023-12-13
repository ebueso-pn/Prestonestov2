import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_dotenv/flutter_dotenv.dart';

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
    final ffApiRequestBody = '''
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
        'Authorization': 'Bearer ${dotenv.env['ZAPSIGN_TOKEN']}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class ZapSignUpdateSignerCall {
  static Future<ApiCallResponse> call({
    String? signerToken = '',
    String? redirectLink = '',
  }) {
    final ffApiRequestBody = '''
{
  "redirect_link": "${redirectLink}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'ZapSign Update Signer',
      apiUrl: 'https://api.zapsign.com.br/api/v1/signers/${signerToken}/',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${dotenv.env['ZAPSIGN_TOKEN']}',
      },
      params: {},
      body: ffApiRequestBody,
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
        'Authorization': 'Bearer ${dotenv.env['SHUFTI_PRO_TOKEN']}',
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
    String? shuftiReference = '777777',
  }) {
    final ffApiRequestBody = '''
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
        'Authorization': 'Bearer ${dotenv.env['SHUFTI_PRO_TOKEN']}',
      },
      params: {},
      body: ffApiRequestBody,
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
  static dynamic verificationresult(dynamic response) => getJsonField(
        response,
        r'''$.verification_result''',
      );
  static dynamic verificationdata(dynamic response) => getJsonField(
        response,
        r'''$.verification_data''',
        true,
      );
  static dynamic additionaldata(dynamic response) => getJsonField(
        response,
        r'''$.additional_data''',
        true,
      );
}

class ShuftiStatusRequestCall {
  static Future<ApiCallResponse> call({
    String? shuftiReference = '210c8cGgadoTjrjZWOw4',
  }) {
    final ffApiRequestBody = '''
{
  "reference": "${shuftiReference}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Shufti Status Request',
      apiUrl: 'https://api.shuftipro.com/',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${dotenv.env['SHUFTI_PRO_TOKEN']}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic status(dynamic response) => getJsonField(
        response,
        r'''$.event''',
      );
  static dynamic verificationData(dynamic response) => getJsonField(
        response,
        r'''$.verification_data''',
        true,
      );
  static dynamic additionalData(dynamic response) => getJsonField(
        response,
        r'''$.additional_data''',
        true,
      );
}

class BeginiTokenCall {
  static Future<ApiCallResponse> call(
      {String? uid = 'test2',
      String? integrationId = '65157cc8e8f64eeabc0dc3bd',
      String? apiKey = ''}) {
    final ffApiRequestBody = '''
{
  "uid": "${uid}",
  "integration_id": "${integrationId}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Begini Token',
      apiUrl: 'https://api.begini.co/v1/sessions-management/tokens',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'api-key': dotenv.env['BEGINI_API_KEY'],
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic accessToken(dynamic response) => getJsonField(
        response,
        r'''$.access_token''',
      );
  static dynamic url(dynamic response) => getJsonField(
        response,
        r'''$.url''',
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
