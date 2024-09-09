import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/home_screen.dart';
import 'package:flutter_application_1/View/profile_screen.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  final List<Widget> _navgationItem = [
    const Icon(Icons.home),
    const Icon(Icons.dashboard),
    const Icon(Icons.qr_code),
    const Icon(Icons.settings),
    const Icon(Icons.person),
  ];

  CustomBottomNavBar({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      backgroundColor: Color(0xFFD6E2EA),
      items: _navgationItem,
      index: currentIndex,
      onTap: (index) {
        if (index == 0) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        } else if (index == 4) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfileScreen()),
          );
        }
        onTap(index);
      },
    );
  }
}
