import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Để xử lý định dạng ngày
import 'package:flutter_application_1/View/e_tag/active_user.dart';
import 'package:flutter_application_1/View/e_tag/inactive_user.dart';

class CheckUserCardScreen extends StatefulWidget {
  const CheckUserCardScreen({Key? key}) : super(key: key);

  @override
  State<CheckUserCardScreen> createState() => _CheckUserCardScreenState();
}

class _CheckUserCardScreenState extends State<CheckUserCardScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, String>> userData = [
    {
      'name': 'Nguyễn Văn A',
      'birthdate': '01/01/1990',
      'hometown': 'Hà Nội',
      'image': 'https://via.placeholder.com/150',
      'startDate': '01/10/2024',
      'endDate': '04/10/2024',
    },
    {
      'name': 'Trần Thị B',
      'birthdate': '15/05/1992',
      'hometown': 'Đà Nẵng',
      'image': 'https://via.placeholder.com/150',
      'startDate': '01/10/2023',
      'endDate': '05/10/2024',
    },
    {
      'name': 'Nguyễn Văn C',
      'birthdate': '15/05/1992',
      'hometown': 'Đà Nẵng',
      'image': 'https://via.placeholder.com/150',
      'startDate': '01/03/2024',
      'endDate': '02/03/2024',
    },
    {
      'name': 'Phạm Thị D',
      'birthdate': '20/07/1993',
      'hometown': 'Hải Phòng',
      'image': 'https://via.placeholder.com/150',
      'startDate': '01/09/2023',
      'endDate': '01/12/2023',
    },
    {
      'name': 'Lê Văn E',
      'birthdate': '02/02/1988',
      'hometown': 'Hồ Chí Minh',
      'image': 'https://via.placeholder.com/150',
      'startDate': '15/09/2023',
      'endDate': '15/12/2023',
    },
    {
      'name': 'Hoàng Thị F',
      'birthdate': '30/03/1990',
      'hometown': 'Nghệ An',
      'image': 'https://via.placeholder.com/150',
      'startDate': '05/10/2023',
      'endDate': '05/11/2023',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Hàm chuyển đổi chuỗi ngày tháng từ 'dd/MM/yyyy' thành DateTime
  DateTime parseDate(String dateString) {
    return DateFormat('dd/MM/yyyy').parse(dateString);
  }

  // Hàm kiểm tra xem thẻ có còn hiệu lực không
  bool isActive(String startDate, String endDate) {
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
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.blue, // Màu của dải chỉ báo
          labelColor: Colors.blue, // Màu chữ khi tab được chọn
          unselectedLabelColor: Colors.black, // Màu chữ khi tab không được chọn
          tabs: const [
            Tab(text: 'Hiệu lực'),
            Tab(text: 'Không hiệu lực'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Tab "Hiệu lực"
          ActiveUsers(
            userData: userData.where((user) {
              return isActive(user['startDate']!, user['endDate']!);
            }).toList(),
          ),
          // Tab "Không hiệu lực"
          InactiveUsers(
            userData: userData.where((user) {
              return !isActive(user['startDate']!, user['endDate']!);
            }).toList(),
          ),
        ],
      ),
    );
  }
}
