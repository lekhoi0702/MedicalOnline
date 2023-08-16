import 'package:customerapp/main.dart';
import 'package:customerapp/src/api/napxu.dart';
import 'package:flutter/material.dart';





class Payment extends StatefulWidget {
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  int selectedAmount = 10;
  int selectedPaymentMethod = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NẠP XU",
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Chọn số xu:'),
            SizedBox(height: 8),
            DropdownButton<int>(
              value: selectedAmount,
              onChanged: (value) {
                setState(() {
                  selectedAmount = value!;
                });
              },
              items: [10, 20, 50, 100, 200, 500]
                  .map<DropdownMenuItem<int>>(
                    (int value) => DropdownMenuItem<int>(
                  value: value,
                  child: Text('$value xu'),
                ),
              )
                  .toList(),
            ),
            SizedBox(height: 16),
            Text('Chọn phương thức thanh toán:'),
            SizedBox(height: 8),
            Column(
              children: [
                ListTile(
                  leading: Icon(Icons.credit_card),
                  title: Text('Ngân hàng'),
                  trailing: Radio<int>(
                    value: 1,
                    groupValue: selectedPaymentMethod,
                    onChanged: (value) {
                      setState(() {
                        selectedPaymentMethod = value!;
                      });
                    },
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.credit_card),
                  title: Text('Visa'),
                  trailing: Radio<int>(
                    value: 2,
                    groupValue: selectedPaymentMethod,
                    onChanged: (value) {
                      setState(() {
                        selectedPaymentMethod = value!;
                      });
                    },
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.credit_card),
                  title: Text('Google Wallet'),
                  trailing: Radio<int>(
                    value: 3,
                    groupValue: selectedPaymentMethod,
                    onChanged: (value) {
                      setState(() {
                        selectedPaymentMethod = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _gotopayment(selectedAmount);
                },
                child: Text('Xác nhận nạp xu'),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void _gotopayment(int xu) async{
    int makh = userData?['maKH'];
    int total = userData?['xu'] + xu;
    dynamic response = await ApiServicePayment.payment(makh,total );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${response['message']}'),
        duration: Duration(seconds: 1),
      ),
    );

  }
}
