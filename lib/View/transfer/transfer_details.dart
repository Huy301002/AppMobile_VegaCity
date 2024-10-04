import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/View/transfer/transfer_failed.dart';
import 'package:flutter_application_1/View/transfer/transfer_success.dart';
import 'package:flutter_application_1/entry_point.dart'; // Để xử lý chức năng copy

class TransferDetails extends StatefulWidget {
  const TransferDetails({super.key});

  @override
  State<TransferDetails> createState() => _TransferDetailsState();
}

class _TransferDetailsState extends State<TransferDetails> {
  String? selectedMethod; // Biến để lưu phương thức thanh toán đã chọn

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // Nền màu trắng
        elevation: 0,
        title: const Text(
          'Chi tiết giao dịch',
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
              Color(0xFFE3F2FD)
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
              // Container với đường viền màu xanh và bo góc nhỏ
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blue, // Đường viền màu xanh
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(8), // Bo góc nhỏ
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Nội dung tên người nhận và mã số ngân hàng
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          // Tên người nhận
                          Text(
                            'Zone A',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          // Mã số ngân hàng
                          Text(
                            '0123456789 - Ngân hàng ABC',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      // Icon copy mã số ngân hàng
                      IconButton(
                        onPressed: () {
                          Clipboard.setData(
                              const ClipboardData(text: "0123456789"));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Đã sao chép mã số ngân hàng')),
                          );
                        },
                        icon: const Icon(Icons.copy),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue[100]!, // Đường viền màu xanh nhạt
                    width: 1.5, // Độ dày đường viền
                  ),
                  borderRadius: BorderRadius.circular(8), // Bo góc
                ),
                padding: const EdgeInsets.all(16.0), // Khoảng cách bên trong
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Tiêu đề số tiền chuyển
                    const Text(
                      'Số tiền chuyển',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Số tiền và đơn vị VND
                    const Text(
                      '300,000 VND',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Khoảng cách giữa số tiền và các thông tin dưới
                    Divider(
                      color: Colors.blue[200], // Màu sắc của đường kẻ
                      thickness: 1.5, // Độ dày của đường kẻ
                      height: 20, // Khoảng cách phía trên và phía dưới đường kẻ
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Ngày chuyển:',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54, // Màu xám nhạt
                          ),
                        ),
                        Text(
                          '01/10/2024',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                        height:
                            4), // Khoảng cách giữa ngày chuyển và nội dung chuyển

                    // Nội dung chuyển
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Nội dung:',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54, // Màu xám nhạt
                          ),
                        ),
                        Text(
                          'Thanh toán dịch vụ',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              // Dòng chọn tài khoản mặc định
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue[100]!, // Đường viền mờ màu xanh
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(8), // Bo góc nhỏ
                ),
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Tiêu đề chọn phương thức thanh toán
                    const Text(
                      'Chọn phương thức thanh toán',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                        height: 12), // Khoảng cách giữa tiêu đề và các tùy chọn

                    // Danh sách các tùy chọn phương thức thanh toán với radio button
                    Column(
                      children: [
                        RadioListTile<String>(
                          title: const Text('VNPay'),
                          value: 'VNPay',
                          groupValue:
                              selectedMethod, // Phương thức hiện đang được chọn
                          onChanged: (String? value) {
                            setState(() {
                              selectedMethod = value!;
                            });
                          },
                        ),
                        RadioListTile<String>(
                          title: const Text('Momo'),
                          value: 'Momo',
                          groupValue:
                              selectedMethod, // Phương thức hiện đang được chọn
                          onChanged: (String? value) {
                            setState(() {
                              selectedMethod = value!;
                            });
                          },
                        ),
                        RadioListTile<String>(
                          title: const Text('ZaloPay'),
                          value: 'ZaloPay',
                          groupValue:
                              selectedMethod, // Phương thức hiện đang được chọn
                          onChanged: (String? value) {
                            setState(() {
                              selectedMethod = value!;
                            });
                          },
                        ),
                        RadioListTile<String>(
                          title: const Text('PayOS'),
                          value: 'PayOS',
                          groupValue:
                              selectedMethod, // Phương thức hiện đang được chọn
                          onChanged: (String? value) {
                            setState(() {
                              selectedMethod = value!;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 4), // Khoảng cách giữa các ô
              Divider(
                color: Colors.blue[200], // Màu sắc của đường kẻ
                thickness: 1.5, // Độ dày của đường kẻ
                height: 20, // Khoảng cách phía trên và phía dưới đường kẻ
              ),
              // Tổng tiền và nút xác nhận
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Tổng tiền:',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        '300,000 VND',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: 365,
                    height: 50,
                    child: MaterialButton(
                      minWidth: double.infinity,
                      color: const Color.fromARGB(255, 30, 144, 255),
                      height: 60,
                      onPressed: () {
                        if (selectedMethod == null) {
                          // Hiển thị SnackBar thông báo nếu chưa chọn phương thức thanh toán
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text('Bạn chưa chọn phương thức thanh toán'),
                              duration:
                                  Duration(seconds: 2), // Độ dài của SnackBar
                            ),
                          );
                        } else {
                          // Nếu đã chọn, điều hướng sang trang TransferSuccess
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const TransferSuccess(), // Chuyển sang trang TransferSuccess
                            ),
                          );
                        }
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      child: const Text(
                        "Xác nhận",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: 18,
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
    );
  }
}
