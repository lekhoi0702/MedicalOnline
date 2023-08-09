import 'package:adminapp/src/main/api/change_status_account.dart';
import 'package:adminapp/src/main/api/reset_password.dart';

import 'package:flutter/material.dart';
import 'dart:math';
import '../../api/doctor_list.dart';
import 'add_doctor.dart';

class DoctorListScreen extends StatefulWidget {
  @override
  _DoctorListScreenState createState() => _DoctorListScreenState();
}

class _DoctorListScreenState extends State<DoctorListScreen> {
  List<dynamic> DoctorList = [];

  @override
  void initState() {
    super.initState();
    _getDoctor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QUẢN LÝ BÁC SĨ",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        // backgroundColor: Colors.white,
        //foregroundColor: Colors.black,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body:
      _buildDoctorTable(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _gotoAddDoctorScreen(context);
        },
        child: Icon(Icons.add),
      ),

    );
  }

  Widget _buildDoctorTable() {
    return ListView.builder(
      itemCount: DoctorList.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          // Hiển thị hàng tiêu đề
          return _buildTableRow(isHeader: true);
        }
        // Hiển thị thông tin khách hàng và nút chi tiết
        return _buildTableRow(Doctor: DoctorList[index - 1]);
      },
    );
  }

  Widget _buildTableRow({bool isHeader = false, dynamic Doctor}) {
    final TextStyle textStyle = TextStyle(fontSize: 16.0);

    if (isHeader) {
      return Container(
        color: Colors.grey[300],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildTableCell('Tài khoản', textStyle),
            _buildTableCell('Mật khẩu', textStyle),
            _buildTableCell('Họ tên', textStyle),
            _buildTableCell("Chuyên khoa", textStyle),
            _buildTableCell("Số điện thoại", textStyle),
            _buildTableCell('Email', textStyle),
            _buildTableCell("Trạng thái", textStyle),

          ],
        ),
      );
    } else {
      return GestureDetector(
        onTap: () {
          _showResetPasswordDialog(Doctor);
        },
        child: Container(
          color: (DoctorList.indexOf(Doctor!) % 2 == 0)
              ? Colors.grey[100]
              : Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _buildTableCell("${Doctor['userName']}", textStyle),
              _buildTableCell('${Doctor['password']}', textStyle),
              _buildTableCell('${Doctor['doctorName']}', textStyle),
              _buildTableCell('${Doctor['chuyenKhoa']}', textStyle),
              _buildTableCell('${Doctor['phoneNumber']}', textStyle),
              _buildTableCell('${Doctor['email']}', textStyle),
              _buildTableCell('${_getStatus(Doctor['status'])}', textStyle),
              _buildActionButton(Doctor),
            ],
          ),
        ),
      );
    }
  }

  void _showResetPasswordDialog(dynamic Doctor) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Reset Password'),
          content: Text('Bạn có chắc muốn reset password cho bác sĩ này?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Đóng dialog
              },
              child: Text('Hủy'),
            ),
            ElevatedButton(
              onPressed: () {
                _resetPassword(Doctor);
                Navigator.of(context).pop(); // Đóng dialog
              },
              child: Text('Reset'),
            ),
          ],
        );
      },
    );
  }

  void _resetPassword(dynamic Doctor) {
    String newPassword = generateRandomPassword();
    dynamic response = ApiServiceResetPassword.reset_password(Doctor['userName'], newPassword);
    Doctor['password'] = newPassword;
    setState(() {
      _getDoctor();
    });
  }



  Widget _buildActionButton(dynamic Doctor) {
    if (Doctor['status'] == 1) {
      return ElevatedButton(
        onPressed: () {
          // Thực hiện chức năng khóa tài khoản ở đây
          _toggleDoctorStatus(Doctor);
        },
        child: Text('Khóa'),
      );
    } else if (Doctor['status'] == 0) {
      return ElevatedButton(
        onPressed: () {
          // Thực hiện chức năng mở khóa tài khoản ở đây
          _toggleDoctorStatus(Doctor);
        },
        child: Text('Mở khóa'),
      );
    } else {
      return SizedBox(); // Không hiển thị nút nếu trạng thái không xác định
    }
  }

  void _toggleDoctorStatus(dynamic Doctor) async {
    int status = Doctor['status'];
    if (Doctor['status'] == 1) {
      status = 0;
    } else if (Doctor['status'] == 0) {
      status = 1;
    }
    await ApiServiceChangeStatus.change_status(Doctor['id'], status);
    setState(() {
      _getDoctor();
    });
  }

  Widget _buildTableCell(String text, TextStyle textStyle) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: textStyle,
        ),
      ),
    );
  }

  void _getDoctor() async {
    try {
      dynamic response = await ApiServiceGetDoctor.get_Doctor();
      //   print(response);
      setState(() {
        DoctorList = response;
      });
    } catch (error) {
      print(error);
    }
  }

  String _getStatus(int status) {
    if (status == 1) {
      return 'Đang hoạt động';
    } else if (status == 0) {
      return 'Bị khóa';
    }
    return 'Trạng thái không xác định';
  }

  void _gotoAddDoctorScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddDoctorScreen()),
    );
  }
  String generateRandomPassword() {
    final random = Random();
    const int length = 4;
    const String chars = '0123456789';
    return String.fromCharCodes(Iterable.generate(
        length, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
  }
}
