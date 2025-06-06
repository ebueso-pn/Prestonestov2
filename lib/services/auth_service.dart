import 'dart:convert';
import '/shared/services/api_client.dart';
import '/shared/services/auth_api.dart';

class AuthService {
  static const String _authBasePath = '/auth';

  /// Registers a user and returns a map with success, tokens, or error message.
  static Future<Map<String, dynamic>> registerUser({
    required String email,
    required String phoneNumber,
    required String password,
    required String idType,
    required String idNumber,
  }) async {
    final apiClient = await ApiClient.create();
    final body = {
      "email": email,
      "phone_number": phoneNumber,
      "password": password,
      "id_type": idType,
      "id_number": idNumber,
    };

    try {
      final response = await apiClient.post('$_authBasePath/register', body: body);

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return {
          'success': true,
          'access_token': data['access_token'],
          'refresh_token': data['refresh_token'],
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

  /// Logs in a user and returns a map with success, tokens, or error message.
  static Future<Map<String, dynamic>> loginUser({
    required String email,
    required String password,
  }) async {
    final apiClient = await ApiClient.create();
    final body = {
      "email": email,
      "password": password,
    };

    try {
      final response = await apiClient.post('$_authBasePath/login', body: body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          'success': true,
          'access_token': data['access_token'],
          'refresh_token': data['refresh_token'],
        };
      } else {
        final error = jsonDecode(response.body)['detail'] ?? '';
        return {
          'success': false,
          'status_code': response.statusCode,
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

  static Future<Map<String, dynamic>> signInWithTokens() async {
    try {
      final apiClient = await ApiClient.create();
      final authApi = AuthApi(apiClient);
      final userInfo = await authApi.fetchMe();
      return {
        'success': true,
        'user': userInfo,
      };
    } catch (e) {
      return {
        'success': false,
        'error': e.toString(),
      };
    }
  }
}
