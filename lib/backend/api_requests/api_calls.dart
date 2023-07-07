import 'dart:convert';
import 'dart:typed_data';

import '../../flutter_flow/flutter_flow_util.dart';

import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

class ZapSIgnCreateDocumentFromTemplateCall {
  static Future<ApiCallResponse> call({
    String? templateId = 'Test Pagare',
    String? signerName = '',
    String? signerEmail = '',
    String? signerPhoneNumber = '',
    String? externalId = '',
  }) {
    final body = '''
{
"brand_name": "PrestoNesto",
"send_automatic_email": true,
"lang": "es",
"template_id":"${templateId}",
"signer_name":"${signerName}",
"signer_email": "${signerEmail}",
"signer_phone_number":"${signerPhoneNumber}",
"external_id": "${externalId}",
"reminder_every_n_days": "1"
}
''';
    return ApiManager.instance.makeApiCall(
      callName: 'ZapSIgn Create Document from Template',
      apiUrl: 'https://api.zapsign.com.br/api/v1/models/create-doc/',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '73d79ffa-832a-4afb-8917-6ddfe6254101',
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
