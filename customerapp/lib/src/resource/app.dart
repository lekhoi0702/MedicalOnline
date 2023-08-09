import 'package:flutter/material.dart';

import 'sign_in/login_page.dart';

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new MaterialApp(
        home: LoginPage(),
      ),
    );
  }
}
