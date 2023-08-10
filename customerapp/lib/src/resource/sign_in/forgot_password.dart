import 'package:customerapp/src/api/check_mail.dart';
import 'package:customerapp/src/api/check_username.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import '../../api/send_mail.dart';
import 'login_page.dart';
import 'package:intl/intl.dart';

import 'new_password.dart';
class ResetPasswordPage extends StatefulWidget {
  @override
  ResetPasswordPageState createState() => ResetPasswordPageState();
}

class ResetPasswordPageState extends State<ResetPasswordPage> {
  String _verificationError = "";
  String _verificationErrorEmail = "";
  String _verificationCode = "";
  String _verificationErrorUserName = "";
  bool _showVerificationCodeInput = false;
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _verificationCodeController = TextEditingController();
  TextEditingController _userNameController = new TextEditingController();



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
                    padding:const EdgeInsets.fromLTRB(0,0,0,10),
                    child: TextField(
                      style:TextStyle(fontSize: 12,color: Colors.black) ,
                      controller: _userNameController,
                      decoration: InputDecoration(
                        labelText: "Tên tài khoản",
                        labelStyle: TextStyle(color: Color(0xff888888),fontSize: 12),
                        border: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Color(0xffCED0D2),width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(6))
                        ),
                        errorText: _verificationErrorUserName.isNotEmpty ? _verificationErrorUserName : null,

                      ),),

                  ),
                  Padding(
                    padding:const EdgeInsets.fromLTRB(0,0,0,10),
                    child: TextField(
                      style:TextStyle(fontSize: 12,color: Colors.black) ,
                      controller: _emailController,
                      decoration: InputDecoration(
                          labelText: "Nhập địa chỉ mail",
                          labelStyle: TextStyle(color: Color(0xff888888),fontSize: 12),
                          border: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Color(0xffCED0D2),width: 1),
                              borderRadius: BorderRadius.all(Radius.circular(6))
                          ),
                        errorText: _verificationErrorEmail.isNotEmpty ? _verificationErrorEmail : null,

                      ),),

                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Visibility(
                      visible: _showVerificationCodeInput, // Hiển thị nếu _showVerificationCodeInput = true
                      child: TextField(
                        style: TextStyle(fontSize: 12, color: Colors.black),
                        controller: _verificationCodeController,
                        decoration: InputDecoration(
                          labelText: "Mã xác nhận",
                          labelStyle: TextStyle(color: Color(0xff888888), fontSize: 12),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffCED0D2), width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                          ),
                          errorText: _verificationError.isNotEmpty ? _verificationError : null,
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
                        onPressed: _showVerificationCodeInput ? onVerifyClicked : onResetClicked,
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                        ),
                        child: Text(
                          _showVerificationCodeInput ? "Xác nhận" : "Gửi mã xác nhận",
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
            )

        ),
      ),
    );
  }


  void onVerifyClicked() {
    String username = _userNameController.text.trim();
    String verificationCodeText = _verificationCodeController.text;
    if (verificationCodeText == _verificationCode) {

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NewPasswordPage(username:username),
        ),
      );
    } else {
      // Kiểm tra nếu mã xác nhận chưa được nhập, hiển thị thông báo lỗi
      if (verificationCodeText.isEmpty) {
        setState(() {
          _verificationError = "Vui lòng nhập mã xác nhận.";
        });
      } else {
        // Mã xác nhận nhập sai, hiển thị thông báo lỗi
        setState(() {
          _verificationError = "Mã xác nhận không đúng. Vui lòng kiểm tra lại.";
        });
      }
    }
  }

  void onResetClicked() async {
    String emailAddress = _emailController.text.trim();
    String username = _userNameController.text.trim();
    if (username.isEmpty){
      setState(() {
        _verificationErrorUserName = "Vui lòng nhập tài khoản";
      });
    } else {
      Map<String, dynamic> result = await ApiServiceCheckUserName.check_user(username);
      print(result);
      if (result['count'] != 1){
        setState(() {
          _verificationErrorUserName = "Tài khoản không hợp lệ";
        });
      }
    }
    if (emailAddress.isEmpty) {
      setState(() {
        _verificationErrorEmail = "Vui lòng nhập địa chỉ email.";
      });
    } else {
      Map<String, dynamic> result = await ApiServiceCheckMail.check_mail(
          username, emailAddress);
      if (result['count'] != 1) {
        setState(() {
          _verificationErrorEmail = "Email không khớp với tài khoản";
        });
      } else {
        try {
          // Gọi hàm gửi mã xác nhận tới email
          String verificationCode = generateRandomCode(); // Hàm để tạo mã xác nhận ngẫu nhiên
          await sendVerificationCode(emailAddress, verificationCode);

          // Set _showVerificationCodeInput thành true để hiển thị ô nhập mã xác nhận và nút xác nhận
          setState(() {
            _showVerificationCodeInput = true;
            _verificationCode = verificationCode; // Lưu mã xác nhận để so sánh sau này
            _verificationError = ""; // Xóa thông báo lỗi nếu có
            _verificationErrorEmail ='';
            _verificationErrorUserName = '';
          });
        } catch (error) {
          // Xử lý lỗi nếu có
          print('Error: $error');
        }
      }
    }

    }
  String generateRandomCode() {
    final random = Random();
    // Generate a random integer between 100000 and 999999 (inclusive)
    int randomCode = random.nextInt(900000) + 100000;
    return randomCode.toString();
  }
  Widget gotoLogin (BuildContext Context) {
    return LoginPage();
  }
}













