import '/shared/services/api_client.dart';

import 'models/user_financials_info.dart';

class UserApi {
  final ApiClient apiClient;

  UserApi._(this.apiClient);

  static Future<UserApi> create() async {
    final apiClient = await ApiClient.create();
    return UserApi._(apiClient);
  }

  Future<bool> updateFinancials(IncomeInfoSchemaRequest data) async {
    final response =
        await apiClient.post('/user/update_financials', body: data.toJson());
    if (response.statusCode == 201) {
      return true;
    } else {
      print('Error updating financials: ${response.statusCode} - ${response.body}');
      return false;
    }
  }
}
