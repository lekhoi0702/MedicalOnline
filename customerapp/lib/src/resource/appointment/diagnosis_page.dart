
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../main.dart';
import '../../api/diagnosis.dart';




class DiagnosisPage extends StatefulWidget {
  final int maKH;
  final int maLH;

  const DiagnosisPage({Key? key, required this.maKH,required this.maLH}) : super(key: key);

  @override
  _DiagnosisPageState createState() => _DiagnosisPageState();
}

class _DiagnosisPageState extends State<DiagnosisPage> {
  Map<String,dynamic>? diagnosis;
  final TextEditingController _ketQuaKhamController = TextEditingController();
  final TextEditingController _donThuocController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getDiagnosis();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CHẨN ĐOÁN",style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Khách hàng: ${diagnosis?['customer_name']}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  "Số điện thoại: ${diagnosis?['phoneNumber']}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  "Ngày hẹn: ${diagnosis?['ngayKham']}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Kết quả khám:",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        diagnosis?['kqKham'] ?? "", // Use the 'ketQuaKham' value from the diagnosis map
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Đơn thuốc:",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        diagnosis?['donThuoc'] ?? "", // Use the 'donThuoc' value from the diagnosis map
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }


  Future<void> _getDiagnosis() async {

    int mabs = widget.maKH;
    int malh = widget.maLH;

    // Gọi API để lưu kết quả khám và đơn thuốc
    dynamic response =
    await ApiServiceGetDiagnosis.get_diagnosis(mabs,malh);
    setState(() {
      diagnosis = response;
    });
    print(diagnosis);

  }




}