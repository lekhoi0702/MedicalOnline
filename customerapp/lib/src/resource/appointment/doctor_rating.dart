import 'package:customerapp/main.dart';
import 'package:customerapp/src/api/create_rating.dart';
import 'package:flutter/material.dart';

class DoctorRatingPage extends StatefulWidget {
  final dynamic appointment;
  const DoctorRatingPage({Key? key, required this.appointment}) : super(key: key);
  @override
  _DoctorRatingPageState createState() => _DoctorRatingPageState();
}

class _DoctorRatingPageState extends State<DoctorRatingPage> {
  int selectedRating = 0;
  TextEditingController reviewController = TextEditingController(); // Controller for review input

  void _selectRating(int rating) {
    setState(() {
      selectedRating = rating;
    });
    saveDoctorRating(rating,reviewController.text);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đánh giá bác sĩ'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Đánh giá bác sĩ ${widget.appointment['doctor_name']}:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 1; i <= 5; i++)
                  IconButton(
                    onPressed: () {
                      _selectRating(i);
                    },
                    icon: Icon(
                      Icons.star,
                      color: i <= selectedRating ? Colors.yellow : Colors.grey,
                    ),
                  ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              selectedRating == 0
                  ? 'Chưa có đánh giá'
                  : 'Bạn đã đánh giá $selectedRating sao',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextField(
              controller: reviewController,
              decoration: InputDecoration(
                labelText: 'Nhận xét',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitRating,
              child: Text('Xác nhận đánh giá'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> saveDoctorRating(int rating, String review) async {
    int malh = widget.appointment['maLH'];
    int makh = userData?['maKH'];
    int mabs = widget.appointment['maBS'];
    String message = review;
    int sao = rating;

    try {
    dynamic  result = await ApiServiceCreateDanhGia.create_danhgia(malh, makh, mabs, message, sao);
    print(result);

    setState(() {
      Navigator.pop(context);
    });
    } catch (error) {
      print('Lỗi khi lưu đánh giá: $error');
    }
  }
}
