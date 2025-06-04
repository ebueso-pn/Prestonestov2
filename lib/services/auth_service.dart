import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String _baseUrl = 'http://192.168.10.112:8000/api/v1/auth';

  /// Registers a user and returns a map with success, tokens, or error message.
  static Future<Map<String, dynamic>> registerUser({
    required String email,
    required String phoneNumber,
    required String password,
    required String idType,
    required String idNumber,
  }) async {
    final url = Uri.parse('$_baseUrl/register');
    final body = {
      "email": email,
      "phone_number": phoneNumber,
      "password": password,
      "id_type": idType,
      "id_number": idNumber,
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

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
    final url = Uri.parse('$_baseUrl/login');
    final body = {
      "email": email,
      "password": password,
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

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
}
