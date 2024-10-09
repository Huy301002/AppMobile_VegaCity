import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Để xử lý định dạng ngày
import 'package:flutter_application_1/View/e_tag/card.dart';

class CheckUserCardScreen extends StatefulWidget {
  const CheckUserCardScreen({Key? key}) : super(key: key);

  @override
  State<CheckUserCardScreen> createState() => _CheckUserCardScreenState();
}

class _CheckUserCardScreenState extends State<CheckUserCardScreen> {
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = '';

  final List<Map<String, String?>> userData = [
    {
      'etag': '123456',
      'name': 'Nguyễn Văn A',
      'birthdate': '01/01/1990',
      'amount': '100.000VND',
      'image': 'https://via.placeholder.com/150',
      'startDate': '01/10/2024',
      'endDate': '10/10/2024',
    },
    {
      'etag': '654321',
      'name': 'Trần Thị B',
      'birthdate': '15/05/1992',
      'amount': '100.000VND',
      'image': 'https://via.placeholder.com/150',
      'startDate': '01/10/2023',
      'endDate': '05/10/2024',
    },
    {
      'etag': '789012',
      'name': 'Nguyễn Văn C',
      'birthdate': '15/05/1992',
      'amount': '100.000VND',
      'image': 'https://via.placeholder.com/150',
      'startDate': '01/03/2024',
      'endDate': '02/03/2024',
    },
    {
      'etag': '987654',
      'name': 'Phạm Thị D',
      'birthdate': '20/07/1993',
      'amount': '100.000VND',
      'image': 'https://via.placeholder.com/150',
      'startDate': '01/09/2023',
      'endDate': '01/12/2023',
    },
    {
      'etag': '123789',
      'name': 'Lê Văn E',
      'birthdate': '02/02/1988',
      'amount': '100.000VND',
      'image': 'https://via.placeholder.com/150',
      'startDate': '15/09/2023',
      'endDate': '15/12/2023',
    },
    {
      'etag': '456987',
      'name': 'Hoàng Thị F',
      'birthdate': '30/03/1990',
      'amount': '100.000VND',
      'image': 'https://via.placeholder.com/150',
      'startDate': '05/10/2023',
      'endDate': '05/11/2023',
    },
  ];

  // Hàm chuyển đổi chuỗi ngày tháng từ 'dd/MM/yyyy' thành DateTime
  DateTime parseDate(String dateString) {
    return DateFormat('dd/MM/yyyy').parse(dateString);
  }

  // Hàm kiểm tra xem thẻ có còn hiệu lực không
  bool isActive(String? startDate, String? endDate) {
    if (startDate == null || endDate == null) return false;

    DateTime start = parseDate(startDate);
    DateTime end = parseDate(endDate);
    DateTime now = DateTime.now();

    // Kiểm tra thẻ có hiệu lực từ startDate đến endDate
    return (now.isAfter(start) || now.isAtSameMomentAs(start)) &&
        (now.isBefore(end) || now.isAtSameMomentAs(end));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[50],
        title: const Text('Kiểm tra thẻ người dùng'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Nhập thẻ eTag của khách hàng...',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: const Icon(Icons.search),
              ),
            ),
          ),
          if (searchQuery.isEmpty)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Hãy nhập thẻ eTag của khách hàng để kiểm tra thông tin thẻ',
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            )
          else
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Builder(
                  builder: (context) {
                    final filteredUsers = userData.where((user) {
                      // Tìm thẻ theo eTag và kiểm tra còn hiệu lực
                      return user['etag'] == searchQuery &&
                          isActive(user['startDate'], user['endDate']);
                    }).toList();

                    if (filteredUsers.isEmpty) {
                      return const Center(
                        child: Text(
                          'Không tìm thấy thẻ eTag khớp hoặc thẻ đã hết hạn.',
                          style: TextStyle(color: Colors.red),
                        ),
                      );
                    }

                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1, // Đặt số lượng cột là 1
                        mainAxisSpacing:
                            16, // Khoảng cách giữa các thẻ theo chiều dọc
                        childAspectRatio:
                            1.7, // Điều chỉnh tỷ lệ chiều rộng và chiều cao
                      ),
                      itemCount: filteredUsers.length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          height: 150, // Chiều cao của UserCard
                          child: UserCard(
                            eTag:
                                filteredUsers[index]['etag'] ?? 'Không rõ eTag',
                            name: filteredUsers[index]['name'] ??
                                'Tên không xác định',
                            birthdate: filteredUsers[index]['birthdate'] ??
                                'Không rõ ngày sinh',
                            amount: filteredUsers[index]['amount'] ??
                                'Không rõ quê quán',
                            imageUrl: filteredUsers[index]['image'] ??
                                'https://via.placeholder.com/150',
                            startDate: filteredUsers[index]['startDate'] ??
                                'Không rõ NPH',
                            endDate: filteredUsers[index]['endDate'] ??
                                'Không rõ HSD',
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
