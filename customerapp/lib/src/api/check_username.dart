import 'package:http/http.dart' as http;
import 'dart:convert';



import '../../main.dart';

class ApiServiceCheckUserName {
  static final String apiUrl = '${ipServer}KHUserName/Check';

  static Future<Map<String, dynamic>> check_user(String username) async {
    Map<String, String> requestBody = {
      'userName': username,
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );
      return jsonDecode(response.body);
    } catch (error) {
      // Xử lý lỗi nếu có
      throw Exception('Error: $error');
    }
  }
}
