import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../main.dart';


class ApiServiceResetPassword {
  static Future<Map<String, dynamic>> reset_password(String username,String password) async {
    final String apiUrl = '${ipServer}ADResetPassword/Doctor/username=$username'; // Thay thế bằng URL API thật của bạn
    final headers = {'Content-Type': 'application/json'};
    final requestBody = {
      'username':username,
      'password':password

    };

    try {
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: headers,
        body: jsonEncode(requestBody),
      );
      return jsonDecode(response.body);

    } catch (error) {
      // Xử lý lỗi nếu có
      throw Exception('Error: $error');
    }
  }
}

