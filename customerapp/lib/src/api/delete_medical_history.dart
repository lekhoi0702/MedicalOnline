import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../main.dart';

class ApiServiceDeleteMedHistory {
  static Future<Map<String, dynamic>> delete_medhistory(int id) async {
    final String apiUrl =
        '${ipServer}KHMedicalHistory/Delete';
    final headers = {'Content-Type': 'application/json'};
    final requestBody = {"id":id};

    try {
      final response = await http.delete(
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
