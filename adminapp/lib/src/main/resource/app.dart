import 'package:flutter/material.dart';

import 'login/login.dart';
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new MaterialApp(
        home:  LoginPage(),
      ),
    );
  }
}
