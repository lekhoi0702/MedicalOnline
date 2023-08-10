import 'package:http/http.dart' as http;
import 'dart:convert';



import '../../main.dart';

class ApiServiceCheckMail {
  static final String apiUrl = '${ipServer}KHForgotPassword/Checkmail';

  static Future<Map<String, dynamic>> check_mail(String username,String email) async {
    Map<String, String> requestBody = {
      'userName': username,
      'email':email
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
