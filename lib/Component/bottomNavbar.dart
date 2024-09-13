import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/home_screen.dart';
import 'package:flutter_application_1/View/profile_screen.dart';
import 'package:flutter_application_1/View/package_screen.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  // Tạo list các icon cùng với text bên dưới với kích thước lớn hơn
  final List<Widget> _navigationItem = [
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.home,
            size: 30, color: Colors.white), // Tăng kích thước icon
        const Text("Home",
            style: TextStyle(
                fontSize: 12, color: Colors.white)), // Tăng kích thước chữ
      ],
    ),
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.dashboard, size: 30, color: Colors.white),
        const Text("Combo",
            style: TextStyle(fontSize: 12, color: Colors.white)),
      ],
    ),
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.qr_code, size: 30, color: Colors.white),
        const Text("QR Code",
            style: TextStyle(fontSize: 12, color: Colors.white)),
      ],
    ),
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.settings, size: 30, color: Colors.white),
        const Text("Settings",
            style: TextStyle(fontSize: 12, color: Colors.white)),
      ],
    ),
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.person, size: 30, color: Colors.white),
        const SizedBox(height: 2),
        const Text("Profile",
            style: TextStyle(fontSize: 14, color: Colors.white)),
      ],
    ),
  ];

  CustomBottomNavBar({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      backgroundColor: Colors.white,
      buttonBackgroundColor:
          Color.fromARGB(255, 30, 144, 255), // Màu xanh cho các ô tròn
      color: Color.fromARGB(255, 30, 144, 255), // Màu xanh cho thanh điều hướng
      height: 60, // Tăng chiều cao của thanh điều hướng nếu cần
      items: _navigationItem,
      index: currentIndex,
      onTap: (index) {
        // Điều hướng đến các màn hình tương ứng khi nhấn icon
        if (index == 0) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        } else if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PackageScreen()),
          );
        } else if (index == 4) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfileScreen()),
          );
        }
        onTap(index); // Gọi hàm onTap để xử lý logic khác nếu cần
      },
    );
  }
}
