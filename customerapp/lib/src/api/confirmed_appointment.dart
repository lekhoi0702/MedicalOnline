import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../main.dart';

class ApiServiceConfirmed {
  static final String apiUrl = '${ipServer}KHAppointmentScreen/Confirm';

  static Future<List<dynamic>> confirmed(int maKH) async {
    Map<String, int> requestBody = {'maKH': maKH};

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );
      return jsonDecode(response.body);
    } catch (error) {
      throw Exception('Error: $error');
    }
  }
}
