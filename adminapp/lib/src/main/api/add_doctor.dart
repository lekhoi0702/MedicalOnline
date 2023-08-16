import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../main.dart';


class ApiServiceAddDoctor {
  static final String apiUrl = '${ipServer}ADCreateAccount/Doctor';

  static Future<Map<String, dynamic>> add_doctor(String username, String password,String firstname, String lastname,
      String phonenumber, String chuyenkhoa, String email, String ngaysinh,String avatar,String gioithieu,String online,String tainha) async {
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
      'gioiThieu':gioithieu,
      'online':online,
      'taiNha':tainha

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
