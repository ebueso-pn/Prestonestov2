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
    String? signUrl = '',
  }) {
    final body = '''
{
  "template_id": "667bb389-b888-4aed-a3d0-cfef75fc86d6",
  "signer_name": "${name}",
  "signer_email": "${email}",
  "signer_phone_number": "${phone}",
  "send_automatic_email": true,
  "send_automatic_whatsapp": false,
  "lang": "es",
  "external_id": "${externalId}",
  "data": [
    {
      "de": "{{NOMBRE COMPLETO}}",
      "para": "${name}"
    },
    {
      "de": "{{DNI}",
      "para": "${dni}"
    },
    {
      "de": "{{PHONE}}",
      "para": "${phone}"
    },
    {
      "de": "{{EMAIL}}",
      "para": "${email}"
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
