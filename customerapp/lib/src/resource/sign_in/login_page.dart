import 'package:customerapp/src/resource/sign_in/register_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';
import '../../api/login.dart';
import '../app.dart';
import '../main_layout.dart';
import 'forgot_password.dart';

void main() => runApp(MyApp());

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isBanned = false;
  bool _showPassword = false;
  String userNameErro = '';
  String passwordErro = '';
  TextEditingController _usernameController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/image/login.png'),
              fit: BoxFit.cover,
            )),
            padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
            constraints: BoxConstraints.expand(),
            // color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.end,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 250,
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
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: TextField(
                      style: TextStyle(fontSize: 14, color: Colors.black),
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: "Tên tài khoản",
                        labelStyle:
                            TextStyle(color: Color(0xff888888), fontSize: 13),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0xffCED0D2), width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(6))),
                        errorText:
                            userNameErro.isNotEmpty ? userNameErro : null,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
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
                                    BorderRadius.all(Radius.circular(6))),
                            errorText:
                                passwordErro.isNotEmpty ? passwordErro : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (_isBanned)
                    Text(
                      'Tài khoản bị khóa',
                      style: TextStyle(color: Colors.red),
                    ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Container(
                      constraints:
                          BoxConstraints.loose(Size(double.infinity, 30)),
                      alignment: AlignmentDirectional.centerEnd,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                        child: InkWell(
                          onTap: () {
                            _navigateToResetPasswordPage(
                                context); // Chuyển sang trang ResetPasswordPage
                          },
                          child: Text(
                            "QUÊN MẬT KHẨU?",
                            style: TextStyle(fontSize: 10, color: Colors.blue),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                      child: RichText(
                          text: TextSpan(
                              text: "Bạn chưa có tài khoản?",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 13),
                              children: <TextSpan>[
                            TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SignUpPage()));
                                  },
                                text: " đăng ký ngay",
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 13))
                          ]))),
                ],
              ),
            )),
      ),
    );
  }

  Future<void> onSignInClicked(BuildContext context) async {
    try {
      String username = _usernameController.text.trim();
      String password = _passController.text.trim();
      if (username.isEmpty) {
        setState(() {
          userNameErro = 'Tài khoản không được để trống';
        });
      } else if (password.isEmpty) {
        setState(() {
          passwordErro = 'Mật khẩu không được để trống';
        });
      } else {
        final response = await ApiServiceLogin.login(
          _usernameController.text,
          _passController.text,
        );
        if (response['status'] == 0) {
          setState(() {
            _isBanned = true;
          });
        } else {
          userData = response;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MainLayout(),
            ),
          );
        }
      }
    } catch (error) {
      setState(() {
        userNameErro = '';
        passwordErro = 'Tài khoản hoặc mật khẩu không đúng';
      });

      // Xử lý lỗi nếu có
      print('Error: $error');
    }
  }

  void gotoSignUpClicked() {
    setState(() {
      Navigator.push(context, MaterialPageRoute(builder: gotoSignUp));
    });
  }

  Widget gotoSignUp(BuildContext Context) {
    return SignUpPage();
  }

  void _navigateToResetPasswordPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ResetPasswordPage()),
    );
  }
}
