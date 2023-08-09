import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../api/sign_up.dart';
import 'login_page.dart';
import 'package:intl/intl.dart';
class NewPasswordPage extends StatefulWidget {
  @override
  NewPasswordPageState createState() => NewPasswordPageState();
}

class NewPasswordPageState extends State<NewPasswordPage> {
  bool _showPassword = false;
  bool _passwordNotEmpty = false;
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
      home: Scaffold (
        body: Container (
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
            constraints: BoxConstraints.expand(),
            // color: Colors.white,
            child: SingleChildScrollView(
              child: Column (
                // mainAxisAlignment: MainAxisAlignment.end,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget> [
                  SizedBox(
                    height: 10,
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,40,0,6),
                    child: Container(
                      width: 100,
                      height: 100,
                      padding: EdgeInsets.all(1),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle

                      ),
                      child: Image.asset('assets/image/logo.png'),

                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,0,0,10),
                    child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Welcome to", style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 15
                          ),),
                          Text("online medical", style: TextStyle(
                              fontFamily: 'fontHome',
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                              fontSize: 30
                          ),),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,0,0,10),
                    child: Stack(
                      alignment: AlignmentDirectional.centerEnd,
                      children: <Widget> [
                        TextField(
                          style:TextStyle(fontSize: 12,color: Colors.black) ,
                          controller: _passController,
                          obscureText: !_showPassword,
                          decoration: InputDecoration(
                              labelText: "Nhập mật khẩu mới",
                              labelStyle: TextStyle(color: Color(0xff888888),fontSize: 12),
                              border: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Color(0xffCED0D2),width: 1),
                                  borderRadius: BorderRadius.all(Radius.circular(6))
                              )
                          ),),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,0,0,10),
                    child: Stack(
                      alignment: AlignmentDirectional.centerEnd,
                      children: <Widget> [
                        TextField(
                          style:TextStyle(fontSize: 12,color: Colors.black) ,
                          controller: _passController2,
                          obscureText: !_showPassword,
                          decoration: InputDecoration(
                              labelText: "Xác nhận mật khẩu mới",
                              labelStyle: TextStyle(color: Color(0xff888888),fontSize: 12),
                              border: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Color(0xffCED0D2),width: 1),
                                  borderRadius: BorderRadius.all(Radius.circular(6))
                              )
                          ),),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,0,0,0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: onSignUpClicked,
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                        ),
                        child: Text("XÁC NHẬN",style: TextStyle(
                          color: Colors.white,
                        ),),
                      ),
                    ),
                  ),
                ],
              ),
            )

        ),
      ),
    );
  }




  void onSignUpClicked() async {
    String username = _usernameController.text;
    String password = _passController.text;
    String firstname = _firstnameController.text;
    String lastname = _lassnameController.text;
    String phonenumber = _phonenumberController.text;
    String ngaysinh  = _birthday.text;
    String email = _emailController.text;


    try {
      Map<String, dynamic> result = await ApiServiceSignUp.sign_up(username, password,firstname,lastname,phonenumber,email,ngaysinh);

      // Xử lý kết quả trả về từ API ở đây, ví dụ chuyển hướng đến trang Home nếu đăng nhập thành công.
      Navigator.push(context, MaterialPageRoute(builder: gotoLogin));
    } catch (error) {
      // Xử lý lỗi nếu có
      print('Error: $error');
    }
  }


  Widget gotoLogin (BuildContext Context) {
    return LoginPage();
  }


  Widget gotoSignUp (BuildContext Context) {
    return NewPasswordPage();
  }
}