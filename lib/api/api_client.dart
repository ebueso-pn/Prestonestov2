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
    final baseUrl = 'http://192.168.10.112:8000/api/v1/user/me';
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
    final response = await http.get(
      Uri.parse('$baseUrl$path'),
      headers: _headers(),
    );
    // TODO: Handle token refresh if needed
    return response;
  }

  Future<http.Response> post(String path, {Map<String, dynamic>? body}) async {
    final response = await http.post(
      Uri.parse('$baseUrl$path'),
      headers: _headers(),
      body: json.encode(body ?? {}),
    );
    // TODO: Handle token refresh if needed
    return response;
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

  // Add put/delete methods as needed
}
