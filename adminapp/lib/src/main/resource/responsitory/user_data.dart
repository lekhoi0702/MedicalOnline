import 'dart:core';
import 'dart:core';

import 'package:flutter/material.dart';

class UserData with ChangeNotifier {
  int? maBS;
  String? firstName;
  String? lastName;
  DateTime? ngaySinh;
  String? chuyenKhoa;
  String? phoneNumber;
  String? email;
  String? danhGia;
  String? gioiThieu;
  String? avatar;
  int? id;
  String? username;
  String? passwrd;
  int? roles;

  // Phương thức để cập nhật dữ liệu
  void updateUserData({
    int? maBS,
    String? firstName,
    String? lastName,
    DateTime? ngaySinh,
    String? phoneNumber,
    String? email,
    String? danhGia,
    String? gioiThieu,
    String? avatar,
    int? id,
    String? username,
    String? passwrd,
    int? roles,
  }) {
    this.maBS = maBS;
    this.firstName = firstName;
    this.lastName = lastName;
    this.ngaySinh = ngaySinh;
    this.phoneNumber = phoneNumber;
    this.email = email;
    this.danhGia = danhGia;
    this.gioiThieu = gioiThieu;
    this.avatar = avatar;
    this.id = id;
    this.username = username;
    this.passwrd = passwrd;
    this.roles = roles;

    // Gọi phương thức notifyListeners để thông báo rằng dữ liệu đã thay đổi
    notifyListeners();
  }
}
