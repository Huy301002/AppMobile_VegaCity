import 'package:flutter/material.dart';
import 'pie_chart.dart';
import 'bar_chart.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  _StatisticsScreenState createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen>
    with SingleTickerProviderStateMixin {
  // Dữ liệu và màu sắc cho Pie Chart
  final Map<String, double> dataMap = {
    "Đơn hàng": 4,
    "Giao dịch": 3,
    "Lỗi phát sinh": 4,
  };
  final List<Color> colorsList = [
    const Color.fromARGB(255, 30, 144, 255),
    Colors.orange,
    Colors.redAccent,
  ];

  // Animation Controller
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();

    _animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 30, 144, 255),
        title: const Text("Dashboard"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Card chứa PieChart
              PieChartCard(
                screenWidth: screenWidth,
                dataMap: dataMap,
                colorsList: colorsList,
              ),
              const SizedBox(height: 16), // Khoảng cách giữa PieChart và Row
              // Row chứa 2 Card nằm ngang
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Card 1
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 1, // Đảm bảo Card có tỉ lệ 1:1 (hình vuông)
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        elevation: 5,
                        child: const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('Total payment',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: 10),
                                Text('1.000.000 VND',
                                    style: TextStyle(fontSize: 12)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16), // Khoảng cách giữa hai card
                  // Card 2
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 1, // Đảm bảo Card có tỉ lệ 1:1 (hình vuông)
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        elevation: 5,
                        child: const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Total get',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(height: 10),
                              Text('1.800.000 VND',
                                  style: TextStyle(fontSize: 12)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                  height: 16), // Khoảng cách giữa Row và các Card mới
              // Column chứa 2 Card xếp chồng
              Column(
                children: [
                  // Card 3
                  SizedBox(
                    width: screenWidth - 32, // Chiều rộng gần bằng màn hình
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween, // Căn đều các cột
                          children: [
                            // Cột 1 - Đơn hàng
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Đơn hàng',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    '5.0',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  const SizedBox(
                                      height:
                                          10), // Khoảng cách giữa text và gạch ngang
                                  Container(
                                    width:
                                        50, // Chiều rộng của đường gạch ngang
                                    height: 2, // Chiều cao của đường gạch ngang
                                    color: const Color.fromARGB(255, 30, 144,
                                        255), // Màu xanh của đường gạch ngang
                                  ),
                                ],
                              ),
                            ),
                            // Đường kẻ dọc 1
                            Container(
                              width: 1, // Độ rộng của đường kẻ dọc
                              height: 50, // Chiều cao của đường kẻ dọc
                              color: const Color.fromARGB(255, 30, 144,
                                  255), // Màu xanh của đường kẻ dọc
                            ),
                            // Cột 2 - Giao dịch
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Giao dịch',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    '4.0',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  const SizedBox(
                                      height:
                                          10), // Khoảng cách giữa text và gạch ngang
                                  Container(
                                    width:
                                        50, // Chiều rộng của đường gạch ngang
                                    height: 2, // Chiều cao của đường gạch ngang
                                    color: const Color.fromARGB(255, 30, 144,
                                        255), // Màu xanh của đường gạch ngang
                                  ),
                                ],
                              ),
                            ),
                            // Đường kẻ dọc 2
                            Container(
                              width: 1, // Độ rộng của đường kẻ dọc
                              height: 50, // Chiều cao của đường kẻ dọc
                              color: const Color.fromARGB(255, 30, 144,
                                  255), // Màu xanh của đường kẻ dọc
                            ),
                            // Cột 3 - Lỗi phát sinh
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Lỗi phát sinh',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    '1.0',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                    width: 50,
                                    height: 2,
                                    color:
                                        const Color.fromARGB(255, 30, 144, 255),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16), // Khoảng cách giữa hai Card
                  SizedBox(
                    width: screenWidth - 32,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child:
                            BarChartSample1(), // Thay thế nội dung của Card 4 bằng BarChartSample1
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
