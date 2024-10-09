import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/profile/widgets/profileheder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: const Color(0xFFF0F0F0), // Background color
          child: Column(
            children: [
              // Sử dụng ProfileHeader từ file riêng
              const ProfileHeader(),
              // Các item menu và bottom navigation vẫn giữ nguyên
              _buildMenuItems(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItems() {
    final menuItems = [
      {'icon': FontAwesomeIcons.lock, 'label': 'Privacy'},
      {'icon': FontAwesomeIcons.infoCircle, 'label': 'Information App'},
      {'icon': FontAwesomeIcons.key, 'label': 'Change Password'},
      {'icon': FontAwesomeIcons.mapMarkerAlt, 'label': 'Address'},
      {'icon': FontAwesomeIcons.signOutAlt, 'label': 'Logout'},
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: menuItems.map((item) {
          return _buildMenuItem(
              item['icon'] as IconData, item['label'] as String);
        }).toList(),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String label) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              FaIcon(icon, color: const Color(0xFFFF6666)),
              const SizedBox(width: 10),
              Text(
                label,
                style: const TextStyle(fontSize: 16, color: Color(0xFF333333)),
              ),
            ],
          ),
          const FaIcon(FontAwesomeIcons.chevronRight, color: Color(0xFF888888)),
        ],
      ),
    );
  }
}
