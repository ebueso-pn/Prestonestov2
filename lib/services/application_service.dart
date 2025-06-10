import 'dart:convert';
import '/shared/services/api_client.dart';

class ApplicationService {
  static const String _basePath = '/application';

  static Future<Map<String, dynamic>> submitInitialParams(Map<String, dynamic> payload) async {
    final apiClient = await ApiClient.create();
    try {
      final response = await apiClient.post('$_basePath/params', body: payload);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return {
          'success': true,
          'data': data,
        };
      } else {
        final error = jsonDecode(response.body)['detail'] ?? '';
        return {
          'success': false,
          'error': error,
        };
      }
    } catch (e) {
      return {
        'success': false,
        'error': 'network',
      };
    }
  }
}
