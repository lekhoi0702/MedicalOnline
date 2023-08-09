
import 'package:customerapp/src/api/appointment_today.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';


import '../../../config.dart';
import '../../../main.dart';
import '../../api/confirmed_appointment.dart';
import '../../api/get_doctor.dart';
import '../../videocall.dart';
import '../doctor_info_page.dart';
import '../medical_history.dart';
import 'appointment/find_doctor.dart';



class HomePage extends StatefulWidget {
//  final Map<String, dynamic> response;

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> AppointmentToday = [];
  List<dynamic> DoctorOnline = [];
  bool hasAppointment = true;

  List<Map<String, dynamic>> medCat = [
    {
      "icon": Icons.book,
      "category": "Tiền sử bệnh",
    },
    {
      "icon": Icons.calendar_today_rounded,
      "category": "Lịch sử khám",
    },

  ];
  @override
  void initState() {
    super.initState();
    _getLichHen(); // Gọi hàm này khi màn hình được tạo
    _getDoctor();

  }
  Widget build(BuildContext context) {



    Config().init(context);
    /*  _getAppointments();*/
    String lastName = userData?['lastName'];
    return MaterialApp(
        home: Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 0,
                vertical: 0,
              ),
              child: SingleChildScrollView(

                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.lightBlue,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              child: Container(

                                child: Image.asset('assets/image/logo.png'),
                              ),

                            ),
                            Text("online medical", style: TextStyle(
                              fontFamily: 'fontHome',
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 23,
                            ),),
                          ],
                        ),
                      ),

                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.lightBlue,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 6,
                                    spreadRadius: 4,
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(

                                      Icons.add,
                                      color: Colors.lightBlue,
                                      size: 35,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  ElevatedButton(
                                    onPressed: () {
                                      // Chuyển đến màn hình form đặt lịch khám khi nhấn nút
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => CreateAppointmentPage()),
                                      );
                                    },
                                    child: Text(
                                      "Đặt lịch khám",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.lightBlue,
                                      padding: EdgeInsets.symmetric(vertical: 12),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                      elevation: 6,
                                      shadowColor: Colors.black12,
                                    ),
                                  ),

                                  SizedBox(height: 5),

                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 6,
                                    spreadRadius: 4,
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF0EEFA),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.library_books,
                                      color: Colors.lightBlue,
                                      size: 35,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  ElevatedButton(
                                    onPressed: () {

                                      // Chuyển đến màn hình form đặt lịch khám khi nhấn nút
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => MedicalHistoryPage()),
                                      );
                                    },
                                    child: Text(
                                      "Tiền sử bệnh",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.white,
                                      padding: EdgeInsets.symmetric(vertical: 12),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                      elevation: 6,
                                      shadowColor: Colors.black12,
                                    ),
                                  ),
                                  SizedBox(height: 5),

                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Config.spaceSmall,
                      Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left:10.0),
                              child: const Text(
                                'Lịch hẹn hôm nay',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Config.spaceSmall,
                            SizedBox(
                              height: 200,
                              child:hasAppointment? ListView.builder(
                                scrollDirection: Axis.horizontal, // Chỉ định trượt ngang
                                shrinkWrap: true,
                                itemCount: AppointmentToday.length,
                                itemBuilder: (context, index) {
                                  dynamic appointment = AppointmentToday[index];
                                  return Container(
                                    width: 330, // Đặt chiều rộng cố định cho mỗi phần tử
                                    margin: EdgeInsets.symmetric(horizontal: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [

                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 4,
                                          spreadRadius: 2,
                                        ),
                                      ],
                                    ),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: Column(
                                        children: [

                                          ListTile(
                                            title: Text(
                                              "Bác sĩ ${appointment['doctor_name']}",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            subtitle: Text("Chuyên khoa ${appointment['chuyenKhoa']}"),

                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 15),
                                            child: Divider(
                                              thickness: 1,
                                              height: 20,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.calendar_month,
                                                    color: Colors.black54,
                                                  ),
                                                  SizedBox(width: 5),
                                                  Text(
                                                    "${appointment['date']}",
                                                    style: TextStyle(
                                                      color: Colors.black54,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.access_time_filled,
                                                    color: Colors.black54,
                                                  ),
                                                  SizedBox(width: 5),
                                                  Text(
                                                    "${appointment['time']}",
                                                    style: TextStyle(
                                                      color: Colors.black54,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                      color: Colors.green,
                                                      shape: BoxShape.circle,
                                                    ),
                                                  ),
                                                  SizedBox(width: 5),
                                                  Text(
                                                    "Đã xác nhận",
                                                    style: TextStyle(
                                                      color: Colors.black54,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 15),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              InkWell(
                                                onTap: () {},
                                                child: Container(
                                                  width: 150,
                                                  padding: EdgeInsets.symmetric(vertical: 12),
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFF4F6FA),
                                                    borderRadius: BorderRadius.circular(10),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "Cancel",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w500,
                                                        color: Colors.black54,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: (){
                                                  _gotoCallVideoPage(appointment['maLH']);
                                                },

                                                child: Container(
                                                  width: 150,
                                                  padding: EdgeInsets.symmetric(vertical: 12),
                                                  decoration: BoxDecoration(
                                                    color: Colors.lightBlue,
                                                    borderRadius: BorderRadius.circular(10),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "Gọi bác sĩ",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w500,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              )
                                  : Center(
                                // Hiển thị thông báo "Chưa có lịch hẹn" nếu không có lịch hẹn
                                child: Text(
                                  'Chưa có lịch hẹn',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Config.spaceSmall,
                      Padding(
                        padding: const EdgeInsets.only(left:10.0),
                        child: const Text(
                          'Top bác sĩ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Config.spaceSmall,
                      SizedBox(

                        height: 100,
                        child: ListView.builder(

                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: DoctorOnline.length,
                            itemBuilder: (context,index) {
                              dynamic doctors = DoctorOnline[index];
                              double danhGia = doctors['danhGia']; // Lấy giá trị đánh giá
                              String formattedDanhGia = danhGia.toStringAsFixed(1);
                              if (danhGia > 4.0) {
                                return Container(
                                  width: 300, // Đặt chiều rộng cố định cho mỗi phần tử
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 4,
                                        spreadRadius: 2,
                                      ),
                                    ],
                                    border: Border.all(
                                      color: Colors.lightBlue, // Màu viền xanh
                                      width: 2.0, // Độ dày viền
                                    ),
                                  ),
                                  // Màu nền của mỗi phần tử

                                  child: ListTile(
                                      leading: CircleAvatar(
                                        backgroundImage: NetworkImage(doctors['avatar']), // Load hình ảnh từ URL
                                        radius: 30,
                                      ),

                                      subtitle: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Bác sĩ: ${doctors['lastName']}'),
                                          Text('Chuyên khoa: ${doctors['chuyenKhoa']}'),
                                          Row(
                                            children: [
                                              Text('Đánh giá: $formattedDanhGia'),
                                              Icon(Icons.star,color: Colors.amber,)
                                            ],
                                          ),


                                        ],
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => DoctorInfoPage(
                                                  doctorID: doctors['id'],
                                                )));
                                      }
                                  ),
                                );
                              }

                            }
                        ),
                      ),

                    ],


                  ),

                ),
              ),
            )
        )
    );
  }
  void _getLichHen() async {

    try {
      dynamic response = await ApiServiceAppointmentToday.appointment_today(userData?['maKH']);
      setState(() {
        AppointmentToday = response;
        hasAppointment = AppointmentToday.isNotEmpty;

      });
    } catch (e) {
      hasAppointment = false;
    }
  }

  void _getDoctor() async {
    try {
      dynamic response = await ApiServiceGetDocTor.get_doctor();
      setState(() {
        DoctorOnline = response;
        print(response);
      });
    } catch (e) {
      print(e);
    }

  }

  void _gotoCallVideoPage(int maLH) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => VideoCallScreen(maLH: maLH)),
    );
  }













}

