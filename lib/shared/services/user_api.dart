import 'dart:convert';
import '/shared/services/api_client.dart';
import '/shared/services/models/user_info.dart';

import 'models/user_financials_info.dart';

class UserApi {
  final ApiClient apiClient;

  UserApi._(this.apiClient);

  static Future<UserApi> create() async {
    final apiClient = await ApiClient.create();
    return UserApi._(apiClient);
  }

  Future<UserInfo> updateFinancials(IncomeInfoSchemaRequest data) async {
    final response =
        await apiClient.post('/user/update_financials', body: data.toJson());
    if (response.statusCode == 201) {
      final jsonData = json.decode(response.body);
      return UserInfo.fromJson(jsonData);
    } else {
      throw Exception('Failed to update user info: ${response.statusCode}');
    }
  }
}
