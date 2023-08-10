import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../main.dart';

class ApiServiceChangePassword {
  static Future<Map<String, dynamic>> change_password(
      String username, String password) async {
    final String apiUrl =
        '${ipServer}KHAccount/ResetPassword/username=$username';
    final headers = {'Content-Type': 'application/json'};
    final requestBody = {"userName": username, "password": password};

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
