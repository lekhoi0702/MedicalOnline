import 'package:flutter/material.dart';

class UserData with ChangeNotifier {
  int? maKH;
  String? firstName;
  String? lastName;
  DateTime? ngaySinh;
  String? phoneNumber;
  String? email;
  int? id;
  String? username;
  String? passwrd;
  int? roles;

  // Phương thức để cập nhật dữ liệu
  void updateUserData({
    int? maKH,
    String? firstName,
    String? lastName,
    DateTime? ngaySinh,
    String? phoneNumber,
    String? email,
    int? id,
    String? username,
    String? passwrd,
    int? roles,
  }) {
    this.maKH = maKH;
    this.firstName = firstName;
    this.lastName = lastName;
    this.ngaySinh = ngaySinh;
    this.phoneNumber = phoneNumber;
    this.email = email;
    this.id = id;
    this.username = username;
    this.passwrd = passwrd;
    this.roles = roles;

    // Gọi phương thức notifyListeners để thông báo rằng dữ liệu đã thay đổi
    notifyListeners();
  }
}
