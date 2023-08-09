import 'package:adminapp/src/main/api/change_status_account.dart';
import 'package:adminapp/src/main/api/customer_list.dart';
import 'package:flutter/material.dart';

class CustomerListScreen extends StatefulWidget {
  @override
  _CustomerListScreenState createState() => _CustomerListScreenState();
}

class _CustomerListScreenState extends State<CustomerListScreen> {
  List<dynamic> customerList = [];

  @override
  void initState() {
    super.initState();
    _getCustomer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QUẢN LÝ KHÁCH HÀNG",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        // backgroundColor: Colors.white,
        //foregroundColor: Colors.black,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: _buildCustomerTable(),
    );
  }

  Widget _buildCustomerTable() {
    return ListView.builder(
      itemCount: customerList.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          // Hiển thị hàng tiêu đề
          return _buildTableRow(isHeader: true);
        }
        // Hiển thị thông tin khách hàng và nút chi tiết
        return _buildTableRow(customer: customerList[index - 1]);
      },
    );
  }

  Widget _buildTableRow({bool isHeader = false, dynamic customer}) {
    final TextStyle textStyle = TextStyle(fontSize: 16.0);

    if (isHeader) {
      return Container(
        color: Colors.grey[300],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildTableCell('Tài khoản', textStyle),
            _buildTableCell('Mật khẩu', textStyle),
            _buildTableCell('Họ tên', textStyle),
            _buildTableCell("Ngày sinh", textStyle),
            _buildTableCell("Số điện thoại", textStyle),
            _buildTableCell('Email', textStyle),
            _buildTableCell("Trạng thái", textStyle),

          ],
        ),
      );
    } else {
      return GestureDetector(
        onTap: () {
          // Xử lý khi nút chi tiết được nhấn
          // Ví dụ: Navigator.push(context, MaterialPageRoute(builder: (context) => CustomerDetailScreen(customer: customer!)));
          // Thay thế dòng trên bằng logic thực tế của bạn
        },
        child: Container(
          color: (customerList.indexOf(customer!) % 2 == 0)
              ? Colors.grey[100]
              : Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _buildTableCell("${customer['userName']}", textStyle),
              _buildTableCell('${customer['password']}', textStyle),
              _buildTableCell('${customer['customerName']}', textStyle),
              _buildTableCell('${customer['ngaySinh']}', textStyle),
              _buildTableCell('${customer['phoneNumber']}', textStyle),
              _buildTableCell('${customer['email']}', textStyle),
              _buildTableCell('${_getStatus(customer['status'])}', textStyle),
              _buildActionButton(customer),
            ],
          ),
        ),
      );
    }
  }

  Widget _buildActionButton(dynamic customer) {
    if (customer['status'] == 1) {
      return ElevatedButton(
        onPressed: () {
          // Thực hiện chức năng khóa tài khoản ở đây
          _toggleCustomerStatus(customer);
        },
        child: Text('Khóa'),
      );
    } else if (customer['status'] == 0) {
      return ElevatedButton(
        onPressed: () {
          // Thực hiện chức năng mở khóa tài khoản ở đây
          _toggleCustomerStatus(customer);
        },
        child: Text('Mở khóa'),
      );
    } else {
      return SizedBox(); // Không hiển thị nút nếu trạng thái không xác định
    }
  }

  void _toggleCustomerStatus(dynamic customer) async {
    int status = customer['status'];
    if (customer['status'] == 1) {
      status = 0;
    } else if (customer['status'] == 0) {
      status = 1;
    }
    await ApiServiceChangeStatus.change_status(customer['id'], status);
    setState(() {
      _getCustomer();
    });
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


  void _getCustomer() async {
    try {
      dynamic response = await ApiServiceGetCustomer.get_customer();
      //   print(response);
      setState(() {
        customerList = response;
      });
    } catch (error) {
      print(error);
    }
  }

  String _getStatus(int status) {
    if (status == 1) {
      return 'Đang hoạt động';
    } else if (status == 0) {
      return 'Bị khóa';
    }
    return 'Trạng thái không xác định';
  }
}
