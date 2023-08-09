import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/painting.dart';
import 'package:sidebarx/sidebarx.dart';

import 'appointment/home.dart';
import 'customer/home.dart';
import 'doctor/home.dart';
import 'login/login.dart';

class HomePage extends StatefulWidget {
//  final Map<String, dynamic> response;

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = SidebarXController(selectedIndex: 0, extended: true);
  final _key = GlobalKey<ScaffoldState>();

  void _handleLogout() {
    // Thực hiện chức năng đăng xuất ở đây
    // Ví dụ:
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Builder(
        builder: (context) {
          final isSmallScreen = MediaQuery.of(context).size.width < 600;
          return Scaffold(
            key: _key,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(0.0),
              child: AppBar(
                backgroundColor: Colors.lightBlue,
                //elevation: 0,
                toolbarHeight: 0,

                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(),
                    Text(
                      "online medical",
                      style: TextStyle(
                        fontFamily: 'fontHome',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 50,
                      ),
                    ),
                  ],
                ),
                /*leading: IconButton(
                  onPressed: () {
                    _key.currentState?.openDrawer();
                  },
                  icon: Icon(Icons.menu,color: Colors.black,),
              ),*/
              ),
            ),
            drawer: SideBarXExample(
              controller: _controller,
              onLogout: _handleLogout,
            ),
            body: Row(
              children: [
                if (!isSmallScreen)
                  SideBarXExample(
                      controller: _controller, onLogout: _handleLogout),
                Expanded(
                  child: Center(
                    child: AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return getPageContent(_controller.selectedIndex);
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Trả về trang con tương ứng với selectedIndex
  Widget getPageContent(int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        return CustomerListScreen(); // Trang Home
      case 1:
        return DoctorListScreen(); // Trang Search
      case 2:
        return ScheduleScreen();
      default:
        return CustomerListScreen(); // Mặc định hiển thị trang Home
    }
  }
}

// Tạo các trang con riêng biệt, ví dụ:

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Settings',
        style: TextStyle(color: Colors.white, fontSize: 40),
      ),
    );
  }
}

class ThemeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Theme',
        style: TextStyle(color: Colors.white, fontSize: 40),
      ),
    );
  }
}

class SideBarXExample extends StatelessWidget {
  const SideBarXExample(
      {Key? key,
      required SidebarXController controller,
      required this.onLogout})
      : _controller = controller,
        super(key: key);
  final SidebarXController _controller;
  final Function onLogout;

  @override
  Widget build(BuildContext context) {
    return SidebarX(
      controller: _controller,
      theme: const SidebarXTheme(
        decoration: BoxDecoration(
            color: Colors.white10,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20))),
        iconTheme: IconThemeData(
          color: Colors.black,
          size: 40,
        ),
        selectedTextStyle: const TextStyle(color: Colors.black),
      ),
      extendedTheme: SidebarXTheme(width: 250),
      footerDivider: Divider(color: Colors.black.withOpacity(0.8), height: 1),
      headerBuilder: (context, extended) {
        return const SizedBox(
          height: 100,
          child: Icon(
            Icons.person,
            size: 60,
            color: Colors.black,
          ),
        );
      },
      items: [
        SidebarXItem(icon: Icons.home, label: 'Khách hàng'),
        SidebarXItem(icon: Icons.person, label: 'Bác sĩ'),
        SidebarXItem(icon: Icons.calendar_month, label: 'Lịch hẹn'),
        SidebarXItem(
          icon: Icons.logout,
          label: 'Đăng xuất',
          onTap: () {
            onLogout();
          },
        ),
      ],
    );
  }
}
