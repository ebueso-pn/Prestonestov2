import 'dart:convert';
import 'package:http/http.dart' as http;
import '/shared/services/api_client.dart';

class ApplicationService {
  static const String _basePath = '/application';

  static Future<Map<String, dynamic>> submitInitialParams(
      Map<String, dynamic> payload) async {
    final apiClient = await ApiClient.create();
    try {
      final response = await apiClient.post('$_basePath/params', body: payload);

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

  /// Accepts a list of files, each as a map with either a 'filePath' (String) or 'bytes' (Uint8List) and 'filename' (String).
  static Future<Map<String, dynamic>> uploadFiles({
    required List<Map<String, dynamic>> files,
    required String fileType,
  }) async {
    final apiClient = await ApiClient.create();
    final uri = Uri.parse('${apiClient.baseUrl}/application/upload_files');
    final request = http.MultipartRequest('POST', uri);

    // Add file_type as a form field
    request.fields['file_type'] = fileType;

    // Attach files (support both filePath and bytes)
    for (final file in files) {
      if (file.containsKey('filePath') && file['filePath'] != null) {
        final multipartFile = await http.MultipartFile.fromPath(
          'files',
          file['filePath'],
          filename: file['filename'],
        );
        request.files.add(multipartFile);
      } else if (file.containsKey('bytes') && file['bytes'] != null) {
        final multipartFile = http.MultipartFile.fromBytes(
          'files',
          file['bytes'],
          filename: file['filename'],
        );
        request.files.add(multipartFile);
      }
    }

    try {
      // Use ApiClient to send the multipart request with correct headers and token handling
      final streamedResponse = await apiClient.sendMultipartRequest(request);
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {'success': true, 'data': data};
      } else {
        final error = jsonDecode(response.body)['detail'] ?? '';
        return {'success': false, 'error': error};
      }
    } catch (e) {
      return {'success': false, 'error': 'network'};
    }
  }
}
