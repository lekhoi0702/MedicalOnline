import 'package:customerapp/src/api/change_password.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../api/sign_up.dart';
import 'login_page.dart';
import 'package:intl/intl.dart';

class NewPasswordPage extends StatefulWidget {
  final String username;

  const NewPasswordPage({Key? key, required this.username}) : super(key: key);

  @override
  NewPasswordPageState createState() => NewPasswordPageState();
}

class NewPasswordPageState extends State<NewPasswordPage> {
  bool _checkpass = false;
  bool _showPassword = false;
  bool _passwordEmpty = false;
  bool _ischange = false;
  TextEditingController _birthday = new TextEditingController();
  TextEditingController _usernameController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();
  TextEditingController _firstnameController = new TextEditingController();
  TextEditingController _lassnameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _phonenumberController = new TextEditingController();
  TextEditingController _passController2 = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
            constraints: BoxConstraints.expand(),
            // color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.end,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 40, 0, 6),
                    child: Container(
                      width: 100,
                      height: 100,
                      padding: EdgeInsets.all(1),
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      child: Image.asset('assets/image/logo.png'),
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
                            "Welcome to",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 15),
                          ),
                          Text(
                            "online medical",
                            style: TextStyle(
                                fontFamily: 'fontHome',
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent,
                                fontSize: 30),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Stack(
                      alignment: AlignmentDirectional.centerEnd,
                      children: <Widget>[
                        TextField(
                          style: TextStyle(fontSize: 12, color: Colors.black),
                          controller: _passController,
                          obscureText: !_showPassword,
                          decoration: InputDecoration(
                              labelText: "Nhập mật khẩu mới",
                              labelStyle: TextStyle(
                                  color: Color(0xff888888), fontSize: 12),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xffCED0D2), width: 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6)))),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Stack(
                      alignment: AlignmentDirectional.centerEnd,
                      children: <Widget>[
                        TextField(
                          style: TextStyle(fontSize: 12, color: Colors.black),
                          controller: _passController2,
                          obscureText: !_showPassword,
                          decoration: InputDecoration(
                              labelText: "Xác nhận mật khẩu mới",
                              labelStyle: TextStyle(
                                  color: Color(0xff888888), fontSize: 12),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xffCED0D2), width: 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6)))),
                        ),
                      ],
                    ),
                  ),
                  if (_checkpass)
                    Text(
                      "Mật khẩu xác thực không chính xác",
                      style: TextStyle(color: Colors.red),
                    ),
                  if (_passwordEmpty)
                    Text(
                      "Mật khẩu không được để trống",
                      style: TextStyle(color: Colors.red),
                    ),
                  if (_ischange)
                    Text(
                      "Đổi mật khẩu thành công",
                      style: TextStyle(color: Colors.red),
                    ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: onSignUpClicked,
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                        ),
                        child: Text(
                          "XÁC NHẬN",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0,20,0,20),
                      child: RichText(
                          text: TextSpan(
                              style: TextStyle(color: Colors.black,fontSize: 13),
                              children: <TextSpan>[
                                TextSpan(
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(context, MaterialPageRoute(builder:(context)=>LoginPage()));
                                      },
                                    text: "Quay lại đăng nhập",
                                    style: TextStyle(
                                        color: Colors.blue,fontSize: 13
                                    )

                                )
                              ]



                          )
                      )),
                ],
              ),
            )),
      ),
    );
  }

  void onSignUpClicked() async {
    String username = widget.username;
    String password1 = _passController.text;
    String password2 = _passController2.text;
    if (password1 != password2) {
      setState(() {
        _checkpass = true;
      });
    } else if (password1 == '' || password2 == '') {
      setState(() {
        _passwordEmpty = true;
      });
    } else {
      try {
        Map<String, dynamic> result =
            await ApiServiceChangePassword.change_password(username, password1);
        setState(() {
          _ischange = true;
        });
      } catch (error) {
        // Xử lý lỗi nếu có
        print('Error: $error');
      }
    }
  }

  Widget gotoLogin(BuildContext Context) {
    return LoginPage();
  }
}
