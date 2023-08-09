import 'package:adminapp/src/main/api/cancel_appointment.dart';
import 'package:adminapp/src/main/api/change_status_account.dart';
import 'package:adminapp/src/main/api/complete_appointment.dart';
import 'package:adminapp/src/main/api/confirm_appointment.dart';
import 'package:adminapp/src/main/resource/appointment/diagnosis.dart';

import 'package:flutter/material.dart';

import '../../api/schedule_list.dart';

class ScheduleScreen extends StatefulWidget {
  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  List<dynamic> Schedule = [];

  @override
  void initState() {
    super.initState();
    _getSchedule();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QUẢN LÝ LỊCH HẸN",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        // backgroundColor: Colors.white,
        //foregroundColor: Colors.black,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: _buildScheduleTable(),
    );
  }

  Widget _buildScheduleTable() {
    return ListView.builder(
      itemCount: Schedule.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          // Hiển thị hàng tiêu đề
          return _buildTableRow(isHeader: true);
        }
        // Hiển thị thông tin khách hàng và nút chi tiết
        return _buildTableRow(Schedule: Schedule[index - 1]);
      },
    );
  }

  Widget _buildTableRow({bool isHeader = false, dynamic Schedule}) {
    final TextStyle textStyle = TextStyle(fontSize: 16.0);

    if (isHeader) {
      return Container(
        color: Colors.grey[300],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildTableCell('Mã lịch hẹn', textStyle),
            _buildTableCell('Khách hàng', textStyle),
            _buildTableCell('Bác sĩ', textStyle),
            _buildTableCell("Ngày hẹn", textStyle),
            _buildTableCell("Giờ hẹn", textStyle),
            _buildTableCell('Trạng thái', textStyle),
          ],
        ),
      );
    } else {
      return GestureDetector(
        onTap: () {
          if (Schedule['status'] == 0) {
            // Show a dialog for unconfirmed schedule
            _showUnconfirmedDialog(Schedule);
          } else if (Schedule['status'] == 1) {
            // Show a dialog for confirmed schedule
            _showConfirmedDialog(Schedule);
          } else if (Schedule['status'] == 2){
            _showCompleteDialog(Schedule);
          }
        },
        child: Container(
          /* color: ( % 2 == 0)
              ? Colors.grey[100]
              : Colors.white,*/
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _buildTableCell("${Schedule['maLH']}", textStyle),
              _buildTableCell('${Schedule['customerName']}', textStyle),
              _buildTableCell('${Schedule['doctorName']}', textStyle),
              _buildTableCell('${Schedule['ngayHen']}', textStyle),
              _buildTableCell('${Schedule['gioHen']}', textStyle),
              _buildTableCell('${_getStatus(Schedule['status'])}', textStyle),
            ],
          ),
        ),
      );
    }
  }

  Widget _buildTableCell(String text, TextStyle textStyle) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: textStyle,
        ),
      ),
    );
  }

  void _getSchedule() async {
    try {
      dynamic response = await ApiServiceGetSchedule.get_schedule();
      //   print(response);
      setState(() {
        Schedule = response;
      });
    } catch (error) {
      print(error);
    }
  }

  String _getStatus(int status) {
    if (status == 0) {
      return 'Chờ xác nhận';
    } else if (status == 1) {
      return 'Đã xác nhận';
    } else if (status == 2) {
      return 'Đã hoàn thành';
    }
    return 'Đã hủy';
  }

  void _showUnconfirmedDialog(dynamic Schedule) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Mã lịch hẹn: ${Schedule['maLH']}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  _confirmAppointment(Schedule);
                  Navigator.pop(context); // Close the dialog
                },
                child: Text('Xác nhận'),
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  _cancelAppointment(Schedule);
                  Navigator.pop(context); // Close the dialog
                },
                child: Text('Hủy lịch'),
              ),
            ],
          ),
        );
      },
    );
  }
  void _showCompleteDialog(dynamic Schedule) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DiagnosisPage(maLH: Schedule['maLH'])),
                  );
                },
                child: Text('Xem chẩn đoán'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showConfirmedDialog(dynamic Schedule) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  _completelAppointment(Schedule);
                  Navigator.pop(context);
                },
                child: Text('Hoàn thành'),
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  _cancelAppointment(Schedule);
                },
                child: Text('Hủy lịch'),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _cancelAppointment(dynamic Schedule) async {
    int malh = Schedule['maLH'];

    // Gọi API để lưu kết quả khám và đơn thuốc
    dynamic response = await ApiServiceDeleteLH.delete_lh(malh);
    setState(() {
      _getSchedule();
    });
  }

  Future<void> _completelAppointment(dynamic Schedule) async {
    int malh = Schedule['maLH'];

    // Gọi API để lưu kết quả khám và đơn thuốc
    dynamic response = await ApiServiceCompleteAppointment.complete_appointment(malh);
    print('${response['message']}');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${response['message']}'),
        duration: Duration(seconds: 1),
      ),
    );
    setState(() {
      _getSchedule();
    });
  }
  Future<void> _confirmAppointment(dynamic Schedule) async {
    int malh = Schedule['maLH'];

    // Gọi API để lưu kết quả khám và đơn thuốc
    dynamic response = await ApiServiceConfirmAppointment.confirm_appointment(malh);
    print('${response['message']}');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${response['message']}'),
        duration: Duration(seconds: 1),
      ),
    );
    setState(() {
      _getSchedule();
    });
  }


}
