import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../main.dart';


class ApiServiceAddDoctor {
  static final String apiUrl = '${ipServer}ADCreateAccount/Doctor'; // Thay thế your_api_url bằng địa chỉ của Flask API

  static Future<Map<String, dynamic>> add_doctor(String username, String password,String firstname, String lastname,
      String phonenumber, String chuyenkhoa, String email, String ngaysinh,String avatar,String gioithieu) async {
    Map<String, String> requestBody = {
      'userName': username,
      'password': password,
      'firstName': firstname,
      'lastName' : lastname,
      'phoneNumber':phonenumber,
      'email':email,
      'ngaySinh': ngaysinh,
      'chuyenKhoa':chuyenkhoa,
      'avatar':avatar,
      'gioiThieu':gioithieu

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
      // Xử lý lỗi nếu có
      throw Exception('Error: $error');
    }
  }
}
