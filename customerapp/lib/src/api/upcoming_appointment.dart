import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../main.dart';



class ApiServiceUpcoming {
  static final String apiUrl = '${ipServer}KHAppointmentScreen/Upcoming'; // Thay thế your_api_url bằng địa chỉ của Flask API

  static Future<List<dynamic>> upcoming(int maKH) async {
    Map<String, int> requestBody = {
      'maKH':maKH
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {

        // Đăng nhập thành công
        return jsonDecode(response.body);
      } else {
        // Đăng nhập thất bại
        throw Exception('Failed to login: ${response.reasonPhrase}');
      }
    } catch (error) {

      throw Exception('Error: $error');
    }
  }


}
