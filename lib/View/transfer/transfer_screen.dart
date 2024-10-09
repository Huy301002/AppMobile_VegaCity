import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/View/transfer/transfer_failed.dart';
import 'package:flutter_application_1/View/transfer/transfer_success.dart';
import 'package:flutter_application_1/entry_point.dart'; // Để xử lý chức năng copy

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  String? selectedMethod; // Biến để lưu phương thức thanh toán đã chọn
  final TextEditingController amountController =
      TextEditingController(); // Để lại chuỗi rỗng
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Đặt listener để xử lý logic thay đổi giá trị
    amountController.addListener(() {
      String currentText = amountController.text;

      // Kiểm tra xem người dùng đã nhập vào hay chưa
      if (currentText.isNotEmpty) {
        // Giữ lại chỉ số, loại bỏ các ký tự không phải số
        String numericText = currentText.replaceAll(RegExp(r'[^0-9]'), '');

        // Cập nhật giá trị của TextField nếu khác
        if (currentText != numericText) {
          amountController.value = TextEditingValue(
            text: numericText,
            selection: TextSelection.collapsed(offset: numericText.length),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // Nền màu trắng
        elevation: 0,
        title: const Text(
          'Chuyển tiền',
          style: TextStyle(
            color: Colors.blue, // Chữ màu xanh
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.blue, // Đặt màu xanh cho icon
        ),
        actions: [
          // Icon Home ở bên phải
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              // Điều hướng về trang EntryPoint()
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EntryPoint(),
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        // Áp dụng màu nền gradient
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Color(0xFFE3F2FD),
            ], // Trắng đến xanh (blue[50])
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Nguồn chuyển tiền',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Nguyễn Văn A',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '0123456789',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      DropdownButton<String>(
                        value: selectedMethod,
                        items: <String>['MoMo', 'VNPay', 'Tiền mặt']
                            .map((String method) {
                          return DropdownMenuItem<String>(
                            value: method,
                            child: Text(method),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedMethod = newValue;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'Chuyển đến',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Nguyễn Văn A',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Text(
                                'E-tag:',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                '0123456789',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Ô nhập số tiền
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        // Ô nhập số tiền
                        TextField(
                          controller: amountController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: '0', // Giữ lại '0' làm hint text
                            hintStyle: TextStyle(
                              color: Colors.blue, // Màu chữ hint
                              fontWeight: FontWeight.bold, // Đặt chữ in đậm
                              fontSize: 16, // Kích thước chữ
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter
                                .digitsOnly, // Chỉ cho phép nhập số
                          ],
                        ),
                        // Chữ "VND" cố định
                        Positioned(
                          right: 10, // Điều chỉnh khoảng cách bên phải
                          child: const Text(
                            'VND',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              // Ô nhập nội dung chuyển tiền
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Nhập nội dung chuyển tiền',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 14),
              Divider(
                color: Colors.blue[200],
                thickness: 1.5,
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[200],
                      padding: const EdgeInsets.only(left: 8),
                      minimumSize: const Size(120, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    child: const Text('Quay về',
                        style: TextStyle(color: Colors.blue, fontSize: 16)),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Action to transfer more
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 30, 144, 255),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      minimumSize: const Size(240, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    child: const Text('Tiếp tục',
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    amountController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
