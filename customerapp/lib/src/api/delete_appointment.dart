import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../main.dart';
class ApiServiceDeleteLH {
  static Future<Map<String, dynamic>> delete_lh(int maLH, int maKH) async {
    final String apiUrl = '${ipServer}KHAppointment/Cancel/malh=$maLH'; // Thay thế bằng URL API thật của bạn
    final headers = {'Content-Type': 'application/json'};
    final requestBody = {
      'maLH': maLH,
      'maKH':maKH
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

