import 'package:customerapp/main.dart';
import 'package:customerapp/src/api/create_medical_history.dart';
import 'package:customerapp/src/api/delete_medical_history.dart';
import 'package:customerapp/src/api/get_medical_history.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MedicalHistoryPage extends StatefulWidget {
  const MedicalHistoryPage({Key? key}) : super(key: key);

  @override
  _MedicalHistoryPageState createState() => _MedicalHistoryPageState();
}

class _MedicalHistoryPageState extends State<MedicalHistoryPage> {
  List<dynamic> medicalRecords = [];

  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _getMedicalHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tiền sử bệnh'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                _showAddMedicalRecordDialog();
              },
              child: Text('Thêm bệnh'),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: medicalRecords.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Bệnh ${medicalRecords[index]['tenBenh']}'),
                    subtitle: Text(
                      'Ngày bắt đầu: ${(medicalRecords[index]['ngayBD'])}',
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                          _deleteMedicalRecord(medicalRecords[index]['id']);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddMedicalRecordDialog() {
    TextEditingController nameController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Thêm bệnh'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Tên bệnh',
                ),
              ),
              SizedBox(height: 16),
              InkWell(
                onTap: () {
                  _selectDate();
                },
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Ngày bắt đầu',
                    hintText: 'yyyy-MM-dd',
                  ),
                  child: Text(
                    _formatDate(selectedDate),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Huỷ'),
            ),
            ElevatedButton(
              onPressed: () {
                String name = nameController.text;
                _addMedicalRecord(name, selectedDate);
                Navigator.of(context).pop();
              },
              child: Text('Xác nhận'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Sử dụng selectedDate làm ngày bắt đầu mặc định
      firstDate: DateTime(1800),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }


  void _getMedicalHistory() async {
    try {
      dynamic result =
          await ApiServiceGetMedHistory.get_medical_history(userData?['maKH']);
      setState(() {
        medicalRecords = result;
      });
    } catch (error) {
      print('Error fetching medical history: $error');
    }
  }

  void _addMedicalRecord(String name, DateTime startDate) async {
    try {
      String formattedStartDate = DateFormat('yyyy-MM-dd').format(startDate);
      dynamic result = await ApiServiceCreateMedHistory.create_medical_history(
          userData?['maKH'], name, formattedStartDate);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${result['message']}'),
          duration: Duration(seconds: 1),
        ),
      );
      setState(() {
        _getMedicalHistory();
      });
    } catch (error) {
      print('Error fetching medical history: $error');
    }
  }

  String _formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }


  void  _deleteMedicalRecord(int id) async {
    try{
      dynamic result = await ApiServiceDeleteMedHistory.delete_medhistory(id);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${result['message']}'),
          duration: Duration(seconds: 1),
        ),
      );
      setState(() {
        _getMedicalHistory();
      });
    } catch (error) {
      print('Error fetching medical history: $error');
    }

  }
}
