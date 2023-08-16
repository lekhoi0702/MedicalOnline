import 'package:customerapp/main.dart';
import 'package:customerapp/src/api/getxu.dart';
import 'package:customerapp/src/resource/paypal.dart';
import 'package:flutter/material.dart';

import '../resource/sign_in/login_page.dart';
import '../resource/sign_in/new_password.dart';



class CustomerProfileScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("THÔNG TIN KHÁCH HÀNG",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        // backgroundColor: Colors.white,
        //foregroundColor: Colors.black,
        centerTitle: true,
        automaticallyImplyLeading: false,

      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CircleAvatar(
              radius: 100,
              backgroundImage: NetworkImage('https://pbs.twimg.com/profile_images/1001963578390265856/ojTGGl_f_400x400.jpg')
            ),
            SizedBox(height: 20),
            Text(
              'Khách hàng ${userData?['firstName']} ${userData?['lastName']}',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              'Số Điện Thoại: ${userData?['phoneNumber']}',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              'Email: ${userData?['email']}',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              'Số xu hiện tại: ${userData?['xu']}',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewPasswordPage(username:userData!['userName'].toString())),
                );
              },
              child: Text('Đổi Mật Khẩu'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text('Đăng Xuất'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Payment()),
                );
              },
              child: Text('Nạp xu'),
            ),
          ],
        ),
      ),
    );
  }
}


