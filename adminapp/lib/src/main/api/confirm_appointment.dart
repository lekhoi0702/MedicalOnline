import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../main.dart';


class ApiServiceConfirmAppointment {
  static Future<Map<String, dynamic>> confirm_appointment(int maLH) async {
    final String apiUrl = '${ipServer}ADAppointment/Confirm/malh=$maLH'; // Thay thế bằng URL API thật của bạn
    final headers = {'Content-Type': 'application/json'};
    final requestBody = {
      'maLH': maLH,

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

