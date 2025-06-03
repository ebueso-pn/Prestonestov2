import 'dart:convert';
import 'package:prestonesto/api/api_client.dart';
import 'package:prestonesto/api/models/user_info.dart';

class AuthApi {
  final ApiClient apiClient;

  AuthApi(this.apiClient);

  Future<UserInfo> fetchMe() async {
    final response = await apiClient.get('/auth/me');
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return UserInfo.fromJson(jsonData);
    } else {
      throw Exception('Failed to fetch user info: ${response.statusCode}');
    }
  }
}
