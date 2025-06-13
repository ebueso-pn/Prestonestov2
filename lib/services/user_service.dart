import 'dart:convert';
import '/shared/services/api_client.dart';

class UserService {
  static const String _userBasePath = '/user';

  static Future<Map<String, dynamic>> submitKyc(
      Map<String, dynamic> payload) async {
    final apiClient = await ApiClient.create();
    try {
      final response =
          await apiClient.post('$_userBasePath/kyc', body: payload);

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

  static Future<Map<String, dynamic>> submitAddress(
      Map<String, dynamic> payload) async {
    final apiClient = await ApiClient.create();
    try {
      final response =
          await apiClient.post('$_userBasePath/update_location', body: payload);

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

  static Future<Map<String, dynamic>> updateCoordinates(
      double latitude, double longitude) async {
    final apiClient = await ApiClient.create();
    try {
      final payload = {
        'latitude': latitude,
        'longitude': longitude,
      };
      final response = await apiClient.post('$_userBasePath/update_coordinates',
          body: payload);

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

  static Future<Map<String, dynamic>> submitBankInfo(
      Map<String, dynamic> payload) async {
    final apiClient = await ApiClient.create();
    try {
      final response = await apiClient.post(
        '$_userBasePath/update_bank_info',
        body: payload,
      );

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
