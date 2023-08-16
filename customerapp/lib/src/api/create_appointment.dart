import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../main.dart';



class ApiServiceCreateLH {
  static final String apiUrl = '${ipServer}KHAppointment/Create';

  static Future<Map<String, dynamic>> create_lh(int makh,int mabs,String ngayhen, String giohen,String gia) async {
    Map<String, String> requestBody = {
      'maKH': makh.toString(),
      'maBS':mabs.toString(),
      'ngayHen':ngayhen,
      'gioHen':giohen,
      'gia':gia


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
