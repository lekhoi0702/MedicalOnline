import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../main.dart';

class ApiServicePayment {
  static Future<Map<String, dynamic>> payment(
      int maKH, int xu) async {
    final String apiUrl =
        '${ipServer}KHPayment/makh=$maKH';
    final headers = {'Content-Type': 'application/json'};
    final requestBody = {"maKH":maKH,"xu":xu};

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
