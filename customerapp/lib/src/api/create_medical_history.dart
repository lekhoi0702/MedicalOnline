import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../main.dart';

class ApiServiceCreateMedHistory {
  static final String apiUrl = '${ipServer}KHMedicalHistory/Create';

  static Future<Map<String, dynamic>> create_medical_history(
      int maKH, String tenbenh, String ngayBD) async {
    Map<String, String> requestBody = {
      "maKH": maKH.toString(),
      "tenBenh": tenbenh,
      "ngayBD": ngayBD
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
