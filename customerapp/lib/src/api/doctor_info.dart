import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../main.dart';



class ApiServiceInfoBS {
  static final String apiUrl = '${ipServer}BSScreen/info';

  static Future<Map<String, dynamic>> info_bacsi(int maBS) async {
    Map<String, int> requestBody = {
      "maBS":maBS

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
