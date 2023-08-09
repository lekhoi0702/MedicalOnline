import 'package:adminapp/src/main/resource/customer/home.dart';
import 'package:adminapp/src/main/resource/main_layout.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../main.dart';
import '../../api/login.dart';
import '../app.dart';

void main() => runApp(MyApp());

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoginError = false;
  bool _showPassword = false;
  bool _passwordNotEmpty = false;
  TextEditingController _usernameController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
            padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
            constraints: BoxConstraints.expand(),
            // color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.end,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 40, 0, 6),
                    child: Container(
                      width: 100,
                      height: 100,
                      padding: EdgeInsets.all(1),
                      decoration: BoxDecoration(shape: BoxShape.circle),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "online medical",
                            style: TextStyle(
                                fontFamily: 'fontHome',
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent,
                                fontSize: 30),
                          ),
                          Text(
                            "For Admin",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(400, 0, 400, 20),
                    child: TextField(
                      style: TextStyle(fontSize: 14, color: Colors.black),
                      controller: _usernameController,
                      decoration: InputDecoration(
                          labelText: "Tên tài khoản",
                          labelStyle:
                              TextStyle(color: Color(0xff888888), fontSize: 13),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xffCED0D2), width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6)))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(400, 0, 400, 10),
                    child: Stack(
                      alignment: AlignmentDirectional.centerEnd,
                      children: <Widget>[
                        TextField(
                          style: TextStyle(fontSize: 15, color: Colors.black),
                          controller: _passController,
                          obscureText: !_showPassword,
                          decoration: InputDecoration(
                              labelText: "Mật khẩu",
                              labelStyle: TextStyle(
                                  color: Color(0xff888888), fontSize: 13),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xffCED0D2), width: 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6)))),
                        ),
                      ],
                    ),
                  ),
                  if (_isLoginError)
                    Text(
                      'Sai tài khoản hoặc mật khẩu',
                      style: TextStyle(color: Colors.red),
                    ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(500, 0, 500, 0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () async {
                          await onSignInClicked(context);
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                        ),
                        child: Text(
                          "ĐĂNG NHẬP",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  Future<void> onSignInClicked(BuildContext context) async {
    try {
      final response = await ApiServiceLogin.login(
        _usernameController.text,
        _passController.text,
      );
      if (response['status'] == 1) {
        userData = response;
        print(userData);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      }
    } catch (error) {
      setState(() {
        _isLoginError = true;
      });
      // Xử lý lỗi nếu có
      print('Error: $error');
      // Hiển thị thông báo lỗi đăng nhập không thành công
    }
  }

  // Hàm hiển thị hộp thoại thông báo khi xảy ra lỗi 401
  void showLoginErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            // Khoảng cách giữa viền và chữ
            child: Center(
              child: Text(
                'Lỗi đăng nhập',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blue), // Màu chữ cho tiêu đề
              ),
            ),
          ),
          content: Text('Sai tài khoản hoặc mật khẩu'),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Đóng'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

/*Widget gotoHome (BuildContext Context) {
    return HomePage();
  }*/
}
