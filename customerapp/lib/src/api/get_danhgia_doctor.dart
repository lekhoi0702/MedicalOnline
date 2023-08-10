import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../main.dart';


class ApiServiceGetDanhGiaBS {
  static final String apiUrl = '${ipServer}BSGetDanhGia'; // Thay thế your_api_url bằng địa chỉ của Flask API

  static Future<List<dynamic>> get_danhgiabs(int maBS) async {
    Map<String, int> requestBody = {
      'maBS':maBS
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
