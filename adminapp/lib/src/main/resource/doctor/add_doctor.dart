import 'package:adminapp/src/main/api/add_doctor.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
class AddDoctorScreen extends StatefulWidget {
  @override
  AddDoctorScreenState createState() => AddDoctorScreenState();
}

class AddDoctorScreenState extends State<AddDoctorScreen> {
  bool _showPassword = false;
  bool _passwordNotEmpty = false;
  TextEditingController _chuyenKhoa = new TextEditingController();
  TextEditingController _usernameController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();
  TextEditingController _firstnameController = new TextEditingController();
  TextEditingController _lassnameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _phonenumberController = new TextEditingController();
  TextEditingController _birthday = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return
       Scaffold (
        appBar: AppBar(
          title: Text("THÊM BÁC SĨ",style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          // backgroundColor: Colors.white,
          //foregroundColor: Colors.black,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              size: 30.0,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),

        ),
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
                    padding: const EdgeInsets.fromLTRB(0,0,0,10),
                    child: TextField(
                      controller: _chuyenKhoa,
                      decoration: const InputDecoration(


                          labelText: "Chuyên khoa",
                          labelStyle: TextStyle(color: Color(0xff888888),fontSize: 12),
                          border: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Color(0xffCED0D2),width: 1),
                              borderRadius: BorderRadius.all(Radius.circular(6))
                          )

                      ),
                      onTap: () async {
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
                  GestureDetector(
                    onTap: () {
                      _pickImage();
                    },
                    child: Container(
                      width: 100,
                      height: 100,
                      padding: EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey, width: 1), // Đường viền xung quanh khung
                        // Nếu bạn muốn thêm ảnh/avatar vào khung, bạn có thể sử dụng BoxDecoration để thêm hình ảnh nền
                        // backgroundImage: AssetImage('assets/avatar_placeholder.png'),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.add_a_photo, // Hoặc biểu tượng tương tự
                          size: 40,
                          color: Colors.grey,
                        ),
                      ),
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
                ],
              ),
            )

        ),
      );
  }
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      String imagePath = pickedFile.path; // Đây là đường dẫn tạm thời đến ảnh được chọn

      // Tách phần đường dẫn sau 'assets/image'
      String remainingPath = imagePath.replaceFirst('assets/image', '');

      // Xóa bỏ ký tự '\' ở đầu
      remainingPath = remainingPath.replaceFirst(RegExp(r'\\'), '');

      // Kết hợp phần còn lại với đường dẫn 'assets/image'
      String assetImagePath = 'assets/image' + remainingPath;
      print(assetImagePath);
    }
  }




  void onSignUpClicked() async {
    String username = _usernameController.text;
    String password = _passController.text;
    String firstname = _firstnameController.text;
    String lastname = _lassnameController.text;
    String phonenumber = _phonenumberController.text;
    String chuyenkhoa  = _chuyenKhoa.text;
    String email = _emailController.text;
    String ngaysinh  = _birthday.text;


    try {
      Map<String, dynamic> result = await ApiServiceAddDoctor.add_doctor(username, password,firstname,lastname,
          phonenumber,chuyenkhoa,email,ngaysinh);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Tạo tài khoản bác sĩ thành công'),
          duration: Duration(seconds: 1),
        ),
      );
    } catch (error) {
      // Xử lý lỗi nếu có
      print('Error: $error');
    }
  }

 /* Widget gotoLogin (BuildContext Context) {
    return LoginPage();
  }
*/

  Widget gotoSignUp (BuildContext Context) {
    return AddDoctorScreen();
  }
}