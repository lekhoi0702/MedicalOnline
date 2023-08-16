import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../main.dart';
class ApiServiceUpdateLH {
  static Future<Map<String, dynamic>> update_lh(int maLH, int maBS, String ngayHen, String gioHen) async {
    final String apiUrl = '${ipServer}KHAppointment/Change/malh=$maLH'; // Thay thế bằng URL API thật của bạn
    final headers = {'Content-Type': 'application/json'};
    final requestBody = {
      'maLH': maLH.toString(),
      'maBS': maBS.toString(),
      'ngayHen': ngayHen,
      'gioHen': gioHen,
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

