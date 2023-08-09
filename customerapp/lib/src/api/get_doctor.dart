import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../main.dart';



class ApiServiceGetDocTor {
  static final String apiUrl = '${ipServer}ADGetDoctor';

  static Future<List<dynamic>> get_doctor() async {

    try {
      final response = await http.get(Uri.parse(apiUrl)
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
