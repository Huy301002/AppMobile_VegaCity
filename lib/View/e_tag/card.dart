import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final String name;
  final String birthdate;
  final String hometown;
  final String imageUrl;
  final String startDate; // Thêm startDate
  final String endDate; // Thêm endDate

  const UserCard({
    Key? key,
    required this.name,
    required this.birthdate,
    required this.hometown,
    required this.imageUrl,
    required this.startDate, // Thêm startDate
    required this.endDate, // Thêm endDate
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      elevation: 4,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
            ),
            child: imageUrl.isNotEmpty
                ? Image.network(
                    imageUrl,
                    height: 110,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                : Container(
                    height: 110,
                    color: Colors.grey[300],
                    child: const Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
          ),
          const SizedBox(height: 18),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Ngày sinh: $birthdate',
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  'Quê quán: $hometown',
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  'NPH: ${startDate.isNotEmpty ? startDate : 'Không có dữ liệu'}',
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  'HSD: ${endDate.isNotEmpty ? endDate : 'Không có dữ liệu'}',
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
