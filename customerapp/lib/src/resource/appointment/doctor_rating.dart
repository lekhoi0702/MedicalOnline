import 'package:customerapp/main.dart';
import 'package:customerapp/src/api/create_rating.dart';
import 'package:customerapp/src/api/get_danhgia.dart';
import 'package:flutter/material.dart';

class DoctorRatingPage extends StatefulWidget {
  final dynamic appointment;

  const DoctorRatingPage({Key? key, required this.appointment})
      : super(key: key);

  @override
  _DoctorRatingPageState createState() => _DoctorRatingPageState();
}

class _DoctorRatingPageState extends State<DoctorRatingPage> {
  Map<String, dynamic> danhgiaRecord = {};
  int selectedRating = 0;
  TextEditingController reviewController = TextEditingController();

  bool hasExistingRating = false; // Kiểm tra xem đã có đánh giá hay chưa

  void _selectRating(int rating) {
    setState(() {
      selectedRating = rating;
    });
  }

  @override
  void initState() {
    super.initState();
    _getDanhgia();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ĐÁNH GIÁ BÁC SĨ",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
                      if (danhgiaRecord.isEmpty) {
                        _selectRating(i);
                      }
                    },
                    icon: Icon(
                      Icons.star,
                      color: i <= selectedRating ? Colors.yellow : Colors.grey,
                    ),
                  ),
              ],
            ),
            SizedBox(height: 20),
            Visibility(
              visible: !hasExistingRating,
              // Ẩn form đánh giá nếu đã có đánh giá
              child: Column(
                children: [
                  TextField(
                    controller: reviewController,
                    decoration: InputDecoration(
                      labelText: 'Nhận xét',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      saveDoctorRating(selectedRating, reviewController.text);
                    },
                    child: Text('Xác nhận đánh giá'),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: hasExistingRating,
              // Hiển thị thông tin đánh giá nếu đã có đánh giá
              child: Column(
                children: [
                  Text(' ${danhgiaRecord['message']}',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                ],
              ),
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
      dynamic result = await ApiServiceCreateDanhGia.create_danhgia(
          malh, makh, mabs, message, sao);
      print(result);
      setState(() {
        hasExistingRating = true; // Đã có đánh giá, hiển thị thông tin đánh giá
        danhgiaRecord = {
          'message': message,
          'sao': sao
        }; // Cập nhật dữ liệu đánh giá
      });
    } catch (error) {
      print('Lỗi khi lưu đánh giá: $error');
    }
  }

  void _getDanhgia() async {
    try {
      dynamic result = await ApiServiceGetDanhGia.get_danhgia(
          userData?['maKH'], widget.appointment['maLH']);
      if (result != null) {
        setState(() {
          hasExistingRating =
              true; // Đã có đánh giá, hiển thị thông tin đánh giá
          danhgiaRecord = result; // Lưu dữ liệu đánh giá
          selectedRating = danhgiaRecord['sao'] ?? 0;
        });
      }
    } catch (error) {
      print('Error fetching doctor rating: $error');
    }
  }
}
