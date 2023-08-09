import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../main.dart';

class ApiServiceGetDoctor {
  static final String apiUrl =
      '${ipServer}ADGetDoctor'; // Thay thế your_api_url bằng địa chỉ của Flask API

  static Future<List<dynamic>> get_Doctor() async {
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
