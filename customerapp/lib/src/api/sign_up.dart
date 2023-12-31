import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../main.dart';

class ApiServiceSignUp {
  static final String apiUrl = '${ipServer}KHSignUp'; // Thay thế your_api_url bằng địa chỉ của Flask API

  static Future<Map<String, dynamic>> sign_up(String username, String password,String firstname, String lastname,
      String phonenumber, String email, String ngaysinh) async {
    Map<String, String> requestBody = {
      'userName': username,
      'password': password,
      'firstName': firstname,
      'lastName' : lastname,
      'phoneNumber':phonenumber,
      'email':email,
      'ngaySinh': ngaysinh,

    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );
      return jsonDecode(response.body);

    } catch (error) {
      // Xử lý lỗi nếu có
      throw Exception('Error: $error');
    }
  }
}
