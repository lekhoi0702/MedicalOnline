import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../main.dart';

class ApiServiceCreateDanhGia {
  static final String apiUrl = '${ipServer}KHCreateDanhGia';

  static Future<Map<String, dynamic>> create_danhgia(
      int malh,int makh, int mabs, String message, int sao) async {
    Map<String, String> requestBody = {
     "maLH":malh.toString(),
      "maKH":makh.toString(),
      "maBS":mabs.toString(),
      "message":message,
      "sao": sao.toString()

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
