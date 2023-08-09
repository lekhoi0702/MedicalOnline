import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../api/sign_up.dart';
import 'login_page.dart';
import 'package:intl/intl.dart';
class SignUpPage extends StatefulWidget {
  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  bool _showPassword = false;
  bool _passwordNotEmpty = false;
  TextEditingController _birthday = new TextEditingController();
  TextEditingController _usernameController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();
  TextEditingController _firstnameController = new TextEditingController();
  TextEditingController _lassnameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _phonenumberController = new TextEditingController();

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
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 5.0),
                            child: TextField(
                              style: TextStyle(fontSize: 12, color: Colors.black),
                              controller: _firstnameController,
                              decoration: InputDecoration(
                                labelText: "Họ",
                                labelStyle: TextStyle(color: Color(0xff888888), fontSize: 12),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xffCED0D2), width: 1),
                                  borderRadius: BorderRadius.all(Radius.circular(6)),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: TextField(
                              style: TextStyle(fontSize: 12, color: Colors.black),
                              controller: _lassnameController,
                              decoration: InputDecoration(
                                labelText: "Tên",
                                labelStyle: TextStyle(color: Color(0xff888888), fontSize: 12),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xffCED0D2), width: 1),
                                  borderRadius: BorderRadius.all(Radius.circular(6)),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:const EdgeInsets.fromLTRB(0,0,0,10),
                    child: TextField(
                      style:TextStyle(fontSize: 12,color: Colors.black) ,
                      controller: _usernameController,
                      decoration: InputDecoration(
                          labelText: "Tên tài khoản",
                          labelStyle: TextStyle(color: Color(0xff888888),fontSize: 12),
                          border: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Color(0xffCED0D2),width: 1),
                              borderRadius: BorderRadius.all(Radius.circular(6))
                          )
                      ),),
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
                              labelText: "Mật khẩu",
                              labelStyle: TextStyle(color: Color(0xff888888),fontSize: 12),
                              border: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Color(0xffCED0D2),width: 1),
                                  borderRadius: BorderRadius.all(Radius.circular(6))
                              )
                          ),),

                        /*GestureDetector(
                        onTap: showPass,
                        child: Text(_showPassword ? "HIDE" : "SHOW",style: TextStyle(color: Colors.blue,fontSize: 12, fontWeight: FontWeight.bold),),
                      )*/


                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,0,0,10),
                    child: TextField(
                      controller: _birthday,
                      decoration: const InputDecoration(


                          labelText: "Năm sinh",
                          labelStyle: TextStyle(color: Color(0xff888888),fontSize: 12),
                          border: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Color(0xffCED0D2),width: 1),
                              borderRadius: BorderRadius.all(Radius.circular(6))
                          )

                      ),
                      onTap: () async {
                        DateTime? pickeddate = await showDatePicker(context: context,
                            initialDate: DateTime.now(), firstDate: DateTime(1800), lastDate: DateTime(2100));
                        if (pickeddate != null) {
                          setState(() {
                            _birthday.text = DateFormat('yyyy-MM-dd').format(pickeddate);
                          });

                        }
                      },

                    ),
                  ),
                  Padding(
                    padding:const EdgeInsets.fromLTRB(0,0,0,10),
                    child: TextField(
                      style:TextStyle(fontSize: 12,color: Colors.black) ,
                      controller: _emailController,
                      decoration: InputDecoration(
                          labelText: "Email",
                          labelStyle: TextStyle(color: Color(0xff888888),fontSize: 12),
                          border: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Color(0xffCED0D2),width: 1),
                              borderRadius: BorderRadius.all(Radius.circular(6))
                          )
                      ),),
                  ),
                  Padding(
                    padding:const EdgeInsets.fromLTRB(0,0,0,10),
                    child: TextField(
                      style:TextStyle(fontSize: 12,color: Colors.black) ,
                      controller: _phonenumberController,
                      decoration: InputDecoration(
                          labelText: "Số điện thoại",
                          labelStyle: TextStyle(color: Color(0xff888888),fontSize: 12),
                          border: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Color(0xffCED0D2),width: 1),
                              borderRadius: BorderRadius.all(Radius.circular(6))
                          )
                      ),),
                  ),


                  Container(
                    constraints: BoxConstraints.loose(Size(double.infinity,30)),
                    alignment: AlignmentDirectional.centerEnd,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0,0,0,5),
                      child: Text(
                          "QUÊN MẬT KHẨU?",
                          style: TextStyle(fontSize: 10,color: Colors.blue)),

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
                        child: Text("ĐĂNG KÝ",style: TextStyle(
                          color: Colors.white,
                        ),),

                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0,20,0,20),
                      child: RichText(
                          text: TextSpan(
                              text: "Bạn đã có tài khoản?",
                              style: TextStyle(color: Colors.black,fontSize: 13),
                              children: <TextSpan>[
                                TextSpan(
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(context, MaterialPageRoute(builder:(context)=>LoginPage()));
                                      },
                                    text: " đăng nhập ngay",
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
    return SignUpPage();
  }
}