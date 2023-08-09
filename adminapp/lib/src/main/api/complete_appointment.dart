import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../main.dart';

class ApiServiceCompleteAppointment {
  static Future<Map<String, dynamic>> complete_appointment(int maLH) async {
    final String apiUrl = '${ipServer}ADAppointment/Complete/malh=$maLH';
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
