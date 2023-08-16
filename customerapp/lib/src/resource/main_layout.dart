
import 'package:customerapp/src/api/profile.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../api/getxu.dart';
import 'appointment/schedule_page.dart';
import 'home_page.dart';





class MainLayout extends StatefulWidget {
  const MainLayout({Key? key}) : super(key: key);

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {

  //variable declaration
  int currentPage = 0;
  final PageController _page = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _page,
        onPageChanged: ((value) {
          setState(() {
            currentPage = value;
          });
        }),
        children: <Widget>[
          const HomePage(),
          ScheduleScreen(),
          CustomerProfileScreen(),

          // ProfilePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
        onTap: (page) {
          setState(() {
            currentPage = page;
            _page.animateToPage(
              page,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
            if (page == 2) {
              _getXu();
            }
          });
        },

        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Lịch hẹn',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Tài khoản',
          ),
        ],
      ),
    );
  }
  void _getXu() async {
    try {
      dynamic response = await ApiServiceGetxu.kh_getxu(userData?['maKH']);
      userData?['xu'] = response['xu'];
    } catch (e) {
      print('Error fetching appointments: $e');
    }
  }

}