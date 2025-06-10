import 'dart:convert';
import '/shared/services/api_client.dart';

class UserService {
  static const String _authBasePath = '/user';

  static Future<Map<String, dynamic>> submitKyc(Map<String, dynamic> payload) async {
    final apiClient = await ApiClient.create();
    try {
      final response = await apiClient.post('$_authBasePath/kyc', body: payload);

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

  static Future<Map<String, dynamic>> submitAddress(Map<String, dynamic> payload) async {
      final apiClient = await ApiClient.create();
      try {
        final response = await apiClient.post('$_authBasePath/update_location', body: payload);

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
