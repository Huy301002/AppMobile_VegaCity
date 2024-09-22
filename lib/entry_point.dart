import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/View/signup/login_screen.dart';
import 'package:flutter_application_1/View/profile/profile_screen.dart';
import 'package:flutter_application_1/View/scanner_qr/scanner_screen.dart';
import 'package:flutter_application_1/View/history/history_screen.dart';
import 'package:flutter_application_1/View/home/Home_Screen.dart';
import 'package:flutter_application_1/View/package_screen.dart';

class EntryPoint extends StatefulWidget {
  final int selectedIndex;

  const EntryPoint({super.key, this.selectedIndex = 0});

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> {
  late int _selectedIndex;
  bool isAuthenticated = false; // Biến kiểm tra xác thực

  // Danh sách các trang tương ứng với từng nút
  static final List<Widget> _screens = [
    HomeScreen(),
    PackageScreen(),
    ScannerScreen(),
    HistoryScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex; // Đặt chỉ mục được chọn từ tham số
    _checkAuthentication(); // Kiểm tra xác thực
  }

  // Hàm kiểm tra xác thực
  Future<void> _checkAuthentication() async {
    final prefs = await SharedPreferences.getInstance();
    bool authenticated =
        prefs.getBool('authenticated') ?? false; // Lấy giá trị xác thực
    setState(() {
      isAuthenticated = authenticated;
    });

    if (!authenticated) {
      // Nếu chưa xác thực, chuyển hướng về màn hình đăng nhập
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!isAuthenticated) {
      // Trường hợp chưa xác thực, không render giao diện EntryPoint
      return const SizedBox.shrink();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: _screens[_selectedIndex],
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
            borderRadius: const BorderRadius.all(Radius.circular(24)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildIcon(Icons.home, "Home", 0),
              buildIcon(Icons.star, "Package", 1),
              buildIcon(Icons.qr_code, "QR Code", 2),
              buildIcon(Icons.timer, "History", 3),
              buildIcon(Icons.person, "Profile", 4),
            ],
          ),
        ),
      ),
    );
  }

  // Hàm xây dựng icon với hiệu ứng AnimatedContainer
  GestureDetector buildIcon(IconData icon, String title, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedBar(isActive: _selectedIndex == index),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 36,
            width: 36,
            child: Icon(
              icon,
              size: 30,
              color: _selectedIndex == index
                  ? const Color.fromARGB(255, 30, 144, 255)
                  : Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: _selectedIndex == index
                  ? const Color.fromARGB(255, 30, 144, 255)
                  : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedBar extends StatelessWidget {
  const AnimatedBar({super.key, required this.isActive});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(bottom: 2),
      height: 4,
      width: isActive ? 20 : 0,
      decoration: BoxDecoration(
        color: isActive ? const Color.fromARGB(255, 30, 144, 255) : Colors.grey,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}
