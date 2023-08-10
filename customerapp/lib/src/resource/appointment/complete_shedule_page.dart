import 'package:customerapp/src/api/complete_appointment.dart';
import 'package:customerapp/src/resource/appointment/doctor_rating.dart';
import 'package:flutter/material.dart';

import '../../../../main.dart';
import 'diagnosis_page.dart';


class CompletedSchedule extends StatefulWidget {
  const CompletedSchedule({Key? key}) : super(key: key);

  @override
  State<CompletedSchedule> createState() => _CompletedScheduleState();
}

class _CompletedScheduleState extends State<CompletedSchedule> {
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
                                        color: Colors.blueAccent,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      "Hoàn thành",
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
                                    _gotoDiagnosisPage(userData?['maKH'],appointment['maLH']);
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
                                        "Chẩn đoán",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                InkWell(
                                  onTap: (){
                                  _gotoDoctorRating(appointment);
                                  },
                                  child: Container(
                                    width: 150,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 12),
                                    decoration: BoxDecoration(
                                      color: Colors.purple,
                                      borderRadius:
                                      BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Đánh giá",
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

  void _getLichHen() async {
    try {
      dynamic response =
      await ApiServiceComplete.complete(userData?['maKH']);
      setState(() {
        appointmentToday = response;
      });
    } catch (e) {
      print('Error fetching appointments: $e');
    }
  }
  void _gotoDiagnosisPage(int maKH, int maLH){
    setState(() {
      Navigator.push(context,
        MaterialPageRoute(builder: (context)=>DiagnosisPage(maKH:maKH,maLH:maLH),),
          );
    });
  }

  void _gotoDoctorRating(dynamic appointment){
    setState(() {
      Navigator.push(context,
        MaterialPageRoute(builder: (context)=>DoctorRatingPage(appointment:appointment),),
      );
    });
  }




}
