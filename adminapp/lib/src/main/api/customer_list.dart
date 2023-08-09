import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../main.dart';

class ApiServiceGetCustomer {
  static final String apiUrl =
      '${ipServer}ADGetCustomer'; // Thay thế your_api_url bằng địa chỉ của Flask API

  static Future<List<dynamic>> get_customer() async {
    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
      );
      return jsonDecode(response.body);
    } catch (error) {
      throw Exception('Error: $error');
    }
  }
}
