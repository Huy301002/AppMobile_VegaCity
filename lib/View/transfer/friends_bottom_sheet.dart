import 'package:flutter/material.dart';

class FriendsBottomSheet extends StatelessWidget {
  const FriendsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      height: 300,
      child: Column(
        children: const [
          Text(
            'Chọn bạn bè',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          // Nội dung cho lựa chọn bạn bè
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Bạn A'),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Bạn B'),
          ),
          // Thêm bạn bè khác
        ],
      ),
    );
  }
}
