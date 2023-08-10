import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:intl/intl.dart';

import '../../../../main.dart';
import '../../api/update_appointment.dart';





class ReschedulePage extends StatefulWidget {
  final int lichhenID;
  final int doctorID;
  ReschedulePage({required this.lichhenID,required this.doctorID});

  @override
  _ReschedulePageState createState() => _ReschedulePageState();
}
class _ReschedulePageState extends State<ReschedulePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  TimeOfDay? _selectedTime = TimeOfDay.now();

  List<String> _hoursList = [];
  String? _selectedHour;

  @override
  void initState() {
    super.initState();
    // Tạo danh sách các giờ cách nhau 30 phút
    for (int hour = 0; hour < 24; hour++) {
      for (int minute = 0; minute < 60; minute += 30) {
        String formattedTime = '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
        _hoursList.add(formattedTime);
      }
    }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("CHỌN KHUNG GIỜ",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
      body: Center(
        child: Column(
          children: [
            TableCalendar(
              firstDay: DateTime.now(),
              lastDay: DateTime.now().add(Duration(days: 365)),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
            ),
            SizedBox(height:10),
            Container(
              height: 70,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _hoursList.length,
                itemBuilder: (context, index) {
                  String hour = _hoursList[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedHour = hour;
                      });
                    },
                    child: Container(
                      width: 100, // Độ rộng ô khung giờ
                      height: 50, // Chiều cao ô khung giờ
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 5), // Khoảng cách giữa các ô khung giờ
                      decoration: BoxDecoration(
                        color: _selectedHour == hour ? Colors.lightBlue : Colors.white, // Màu nền của ô khung giờ khi được chọn
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.lightBlue, width: 1), // Viền xung quanh ô khung giờ
                      ),
                      child: Text(hour),
                    ),
                  );
                },
              ),
            )



          ],

        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(15),
        height: 90,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

            ),

            InkWell(
              onTap: _CreateCalendar,
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 18),
                decoration: BoxDecoration(
                  color: Colors.lightBlue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "Đặt lịch",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }
  String formatTime(TimeOfDay time) {
    final now = DateTime.now();
    final dateTime = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  void _CreateCalendar() async {
    final formattedDate = formatDate(_selectedDay);
    final formattedTime = _selectedHour;

    if (formattedTime == null) {
      // Hiển thị thông báo khi không chọn giờ
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Vui lòng chọn giờ'),
          duration: Duration(seconds: 1),
        ),
      );
      return; // Kết thúc hàm và không tiếp tục thực hiện đặt lịch
    }

    dynamic maKH = userData?['maKH'];
    dynamic maBS = widget.doctorID;
    dynamic maLH = widget.lichhenID;
    print(formattedTime);

    try {
      Map<String, dynamic> result = await ApiServiceUpdateLH.update_lh(maLH,maBS,formattedDate,formattedTime);
      if (result.containsKey('message')) {
        String message = result['message'];
        print(message);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$message'),
            duration: Duration(seconds: 1),
          ),
        );
        return;

      }
    } catch (error) {
      print(error);
      //showCreateLHErrorDialog(context);
      // Xử lý lỗi nếu có

    }
  }






}
