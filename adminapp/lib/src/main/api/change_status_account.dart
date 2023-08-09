import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../main.dart';



class ApiServiceChangeStatus {
  static final String apiUrl = '${ipServer}ADChangeStatus';

  static Future<Map<String, dynamic>> change_status(int id, int status) async {
    Map<String, String> requestBody = {
      'id': id.toString(),
      'status': status.toString()

    };
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        // Đăng nhập thành công
        return jsonDecode(response.body);
      } else {
        // Đăng nhập thất bại
        throw Exception('Failed to login: ${response.reasonPhrase}');
      }
    } catch (error) {
      // Xử lý lỗi nếu có
      throw Exception('Error: $error');
    }
  }
}
