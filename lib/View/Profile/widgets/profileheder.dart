import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(
              'https://storage.googleapis.com/a1aa/image/AIJWYycfWQz2PCcPXft9n2zwmgqWmK6YVTwLkmUi1ZKfj6JnA.jpg',
            ),
            foregroundColor: const Color(0xFF00AFFF),
            backgroundColor: Colors.grey.shade300,
          ),
          const SizedBox(height: 10),
          const Text(
            'Trần Huy Hoàng',
            style: TextStyle(fontSize: 20, color: Color(0xFF333333)),
          ),
          const SizedBox(height: 5),
          const Text(
            'huyhoangrt009@gmail.com',
            style: TextStyle(color: Color(0xFF888888)),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              // Edit profile action
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFCC00),
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text('Edit Profile'),
          ),
        ],
      ),
    );
  }
}
