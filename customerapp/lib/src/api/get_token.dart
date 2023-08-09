import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../main.dart';


class ApiServiceGetVideoCall {
  static final String apiUrl = '${ipServer}BSCallVideo/GetVideoCall'; // Thay thế your_api_url bằng địa chỉ của Flask API

  static Future<Map<String,dynamic>> get_video(int maLH) async {
    Map<String, int> requestBody = {
      'maLH':maLH
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
