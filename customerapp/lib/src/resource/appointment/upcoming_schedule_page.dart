
import 'package:customerapp/src/resource/appointment/reschedule_page.dart';
import 'package:flutter/material.dart';

import '../../../../main.dart';
import '../../api/delete_appointment.dart';
import '../../api/napxu.dart';
import '../../api/upcoming_appointment.dart';



class UpcomingSchedule extends StatefulWidget {
  const UpcomingSchedule({Key? key}) : super(key: key);

  @override
  State<UpcomingSchedule> createState() => _UpcomingScheduleState();
}

class _UpcomingScheduleState extends State<UpcomingSchedule> {
  List<dynamic> appointmentToday = [];

  @override
  void initState() {
    super.initState();
    _getLichHen();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 500,
            child: appointmentToday.isNotEmpty
                ? ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: appointmentToday.length,
              itemBuilder: (context, index) {
                dynamic appointment = appointmentToday[index];
                return Column(
                  children: [
                    Container(
                      width: 330,
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
                              subtitle: Text(
                                  "Chuyên khoa ${appointment['chuyenKhoa']}"),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15),
                              child: Divider(
                                thickness: 1,
                                height: 20,
                              ),
                            ),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceAround,
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
                                        color: Colors.yellow,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      "Chờ xác nhận",
                                      style: TextStyle(
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(height: 15),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: (){
                                    _showConfirmationDialog(appointment['maLH'], userData?['maKH'],appointment['giaOnline']);
                                  },
                                  child: Container(
                                    width: 150,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 12),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF4F6FA),
                                      borderRadius:
                                      BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Hủy Lịch",
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
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ReschedulePage(
                                              lichhenID:
                                              appointment['maLH'],
                                              doctorID: appointment['maBs'],
                                            ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: 150,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 12),
                                    decoration: BoxDecoration(
                                      color: Colors.lightBlue,
                                      borderRadius:
                                      BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Đổi lịch",
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
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10), // Khoảng cách giữa các lịch hẹn
                  ],
                );
              },
            )
                : Center(
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
    );
  }

  Future<void> _cancelLichHen(int maLH, int maKH, int gia) async {
    try {

      await ApiServiceDeleteLH.delete_lh(maLH, maKH);

      setState(() {
        _gotopayment(gia);
        _getLichHen();
      });
    } catch (e) {
      // Handle any errors that occurred during the API call
      print('Error cancelling appointment: $e');
    }
  }

/*  void _gotopayment() {
    int makh = userData?['maKH'];
    int total = userData?['xu']  - widget.giaDoctor;
    print(total);
    dynamic response =  ApiServicePayment.payment(makh,total );

  }*/



  Future<void> _showConfirmationDialog(int maLH, int maBS,int gia) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // Prevent the dialog from being dismissed by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          shape:RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: BorderSide(
              color: Colors.yellow,
              width: 3.0,
            ),
          ),
          backgroundColor: Colors.white,
          title: Text('Xác nhận hủy lịch',textAlign: TextAlign.center,style: TextStyle(color: Colors.blue),),
          contentTextStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Bạn có chắc chắn muốn hủy lịch hẹn này?',textAlign: TextAlign.center,style: TextStyle(
                  color: Colors.black,
                ),),

              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Có',style: TextStyle(
                color: Colors.blue,
              ),),
              onPressed: () {
                // Call the function to cancel the appointment
                _cancelLichHen(maLH, maBS,gia);
                Navigator.of(context).pop(); // Close the dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Hủy thành công'),
                    duration: Duration(seconds: 1),
                  ),
                );
              },
            ),
            TextButton(
              child: Text('Không',style: TextStyle(
                color: Colors.blue, // Đặt màu chữ nút thành xanh
              ),),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }
  void _getLichHen() async {
    try {
      dynamic response =
      await ApiServiceUpcoming.upcoming(userData?['maKH']);
      setState(() {
        appointmentToday = response;
      });
    } catch (e) {
      print('Error fetching appointments: $e');
    }
  }


  void _gotopayment(int xu) async{
    int makh = userData?['maKH'];
    int total = userData?['xu'] + xu;
    dynamic response = await ApiServicePayment.payment(makh,total );

  }
}
