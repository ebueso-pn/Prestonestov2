import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  final String baseUrl;
  String? accessToken;
  String? refreshToken;

  ApiClient._({
    required this.baseUrl,
    this.accessToken,
    this.refreshToken,
  });

  static Future<ApiClient> create() async {
    final baseUrl = 'http://192.168.10.112:8000/api/v1';
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token');
    final refreshToken = prefs.getString('refresh_token');
    return ApiClient._(
      baseUrl: baseUrl,
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }

  Future<http.Response> get(String path) async {
    var response = await http.get(
      Uri.parse('$baseUrl$path'),
      headers: _headers(),
    );
    if (_isAuthError(response)) {
      final refreshed = await _refreshToken();
      if (refreshed) {
        response = await http.get(
          Uri.parse('$baseUrl$path'),
          headers: _headers(),
        );
      } else {
        await logout();
      }
    }
    return response;
  }

  Future<http.Response> post(String path, {Map<String, dynamic>? body}) async {
    var response = await http.post(
      Uri.parse('$baseUrl$path'),
      headers: _headers(),
      body: json.encode(body ?? {}),
    );
    if (_isAuthError(response)) {
      final refreshed = await _refreshToken();
      if (refreshed) {
        response = await http.post(
          Uri.parse('$baseUrl$path'),
          headers: _headers(),
          body: json.encode(body ?? {}),
        );
      } else {
        await logout();
      }
    }
    return response;
  }

  bool _isAuthError(http.Response response) {
    return response.statusCode == 401 || response.statusCode == 403;
  }

  Future<bool> _refreshToken() async {
    if (refreshToken == null) return false;
    final prefs = await SharedPreferences.getInstance();
    final response = await http
        .post(Uri.parse('$baseUrl/auth/refresh/'), // Adjust endpoint as needed
            headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $refreshToken',
        });
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      accessToken = data['access'];
      refreshToken = data['refresh'] ?? refreshToken;
      await prefs.setString('access_token', accessToken!);
      if (data['refresh'] != null) {
        await prefs.setString('refresh_token', refreshToken!);
      }
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    await prefs.remove('refresh_token');
    accessToken = null;
    refreshToken = null;
  }

  Map<String, String> _headers() {
    final headers = <String, String>{
      'Content-Type': 'application/json',
    };
    if (accessToken != null) {
      headers['Authorization'] = 'Bearer $accessToken';
    }
    return headers;
  }
}
