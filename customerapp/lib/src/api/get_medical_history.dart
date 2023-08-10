import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../main.dart';


class ApiServiceGetMedHistory {
  static final String apiUrl = '${ipServer}KHMedicalHistory/Get';
  static Future<List<dynamic>> get_medical_history(int maKH) async {
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
