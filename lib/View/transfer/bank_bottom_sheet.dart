import 'package:flutter/material.dart';

class BankBottomSheet extends StatefulWidget {
  const BankBottomSheet({super.key});

  @override
  _BankBottomSheetState createState() => _BankBottomSheetState();
}

class _BankBottomSheetState extends State<BankBottomSheet> {
  // Danh sách ngân hàng mẫu
  final List<String> banks = [
    'Ngân hàng A',
    'Ngân hàng B',
    'Ngân hàng C',
    'Ngân hàng D',
    'Ngân hàng E',
    // Thêm nhiều ngân hàng khác nếu cần
  ];

  // Biến để lưu trữ từ khóa tìm kiếm
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      height: 400,
      child: Column(
        children: [
          const Text(
            'Chọn ngân hàng',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          // TextField cho tìm kiếm ngân hàng
          TextField(
            onChanged: (value) {
              setState(() {
                searchQuery = value.toLowerCase(); // Cập nhật từ khóa tìm kiếm
              });
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Tìm kiếm ngân hàng...',
              prefixIcon: const Icon(Icons.search),
            ),
          ),
          const SizedBox(height: 20),

          // Danh sách ngân hàng dưới dạng Grid
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // 3 ô trên cùng 1 hàng
                crossAxisSpacing:
                    10.0, // Khoảng cách giữa các ô theo chiều ngang
                mainAxisSpacing: 10.0, // Khoảng cách giữa các ô theo chiều dọc
                childAspectRatio: 1.0, // Tỷ lệ chiều rộng/chiều cao
              ),
              itemCount: banks
                  .where((bank) => bank.toLowerCase().contains(searchQuery))
                  .length,
              itemBuilder: (context, index) {
                final bank = banks
                    .where((bank) => bank.toLowerCase().contains(searchQuery))
                    .toList()[index];
                return Card(
                  elevation: 4, // Độ nổi của ô
                  child: Padding(
                    padding: const EdgeInsets.all(8.0), // Padding cho ô
                    child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment.center, // Căn giữa theo chiều dọc
                      children: [
                        const Icon(
                          Icons.account_balance_outlined,
                          size: 40, // Kích thước biểu tượng
                        ),
                        const SizedBox(
                            height:
                                8), // Khoảng cách giữa biểu tượng và tên ngân hàng
                        Text(
                          bank,
                          textAlign: TextAlign.center, // Căn giữa tên ngân hàng
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
