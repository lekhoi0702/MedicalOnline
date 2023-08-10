import 'package:http/http.dart' as http;
import 'dart:convert';


import '../../main.dart';

class ApiServiceComplete {
  static final String apiUrl = '${ipServer}KHAppointmentScreen/Complete'; // Thay thế your_api_url bằng địa chỉ của Flask API

  static Future<List<dynamic>> complete(int maKH) async {
    Map<String, int> requestBody = {
      'maKH':maKH
    };

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
