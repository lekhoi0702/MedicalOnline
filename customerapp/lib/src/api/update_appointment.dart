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

      if (response.statusCode == 201) {
        // Update lịch hẹn thành công
        return jsonDecode(response.body);
        print(response);
      } else {
        // Có lỗi xảy ra khi update lịch hẹn
        throw Exception('Failed to update appointment: ${response.reasonPhrase}');
      }
    } catch (error) {
      // Xử lý lỗi nếu có
      throw Exception('Error: $error');
    }
  }
}

