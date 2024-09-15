import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/history/history_screen.dart';
import 'package:flutter_application_1/View/home_screen.dart';
import 'package:flutter_application_1/View/profile_screen.dart';
import 'package:flutter_application_1/View/package_screen.dart';

class Bottomnavbar extends StatefulWidget {
  const Bottomnavbar({super.key});

  @override
  State<Bottomnavbar> createState() => _BottomnavbarState();
}

class _BottomnavbarState extends State<Bottomnavbar> {
  int _selectedIndex = 0;

  static final List<Widget> _screens = [
    HomeScreen(),
    PackageScreen(),
    Placeholder(),
    HistoryScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildNavBarItem(CupertinoIcons.home, 'Home', 0),
            buildNavBarItem(CupertinoIcons.creditcard, 'Package', 1),
            const SizedBox(
              width: 20,
            ),
            buildNavBarItem(CupertinoIcons.clock, 'History', 3),
            buildNavBarItem(CupertinoIcons.profile_circled, 'Setting', 4),
          ],
        ),
      ),
      floatingActionButton: ClipOval(
        child: Material(
          color: Color.fromARGB(255, 30, 144, 255),
          elevation: 10,
          child: InkWell(
            child: SizedBox(
              width: 56,
              height: 56,
              child: Icon(
                CupertinoIcons.qrcode_viewfinder,
                size: 28,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget buildNavBarItem(IconData icon, String label, int index) {
    return InkWell(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: _selectedIndex == index
                ? Color.fromARGB(255, 30, 144, 255)
                : Colors.grey,
          ),
          Text(label,
              style: TextStyle(
                color: _selectedIndex == index
                    ? Color.fromARGB(255, 30, 144, 255)
                    : Colors.grey,
              )),
        ],
      ),
    );
  }
}
