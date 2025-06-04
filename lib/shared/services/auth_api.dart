import 'dart:convert';
import '/shared/services/api_client.dart';
import '/shared/services/models/user_info.dart';

class AuthApi {
  final ApiClient apiClient;

  AuthApi(this.apiClient);

  Future<UserInfo> fetchMe() async {
    final response = await apiClient.get('/user/me');
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return UserInfo.fromJson(jsonData);
    } else {
      throw Exception('Failed to fetch user info: ${response.statusCode}');
    }
  }
}
