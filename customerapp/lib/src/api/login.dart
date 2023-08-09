import 'package:http/http.dart' as http;
import 'dart:convert';



import '../../main.dart';

class ApiServiceLogin {
  static final String apiUrl = '${ipServer}KHLogIn';

  static Future<Map<String, dynamic>> login(String username, String password) async {
    Map<String, String> requestBody = {
      'username': username,
      'password': password,

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
