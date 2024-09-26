import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/e_tag/card.dart';

class CheckUserCardScreen extends StatefulWidget {
  const CheckUserCardScreen({Key? key}) : super(key: key);

  @override
  State<CheckUserCardScreen> createState() => _CheckUserCardScreenState();
}

class _CheckUserCardScreenState extends State<CheckUserCardScreen> {
  final TextEditingController _searchController = TextEditingController();

  // Giả lập danh sách người dùng (dùng cho tìm kiếm)
  final List<Map<String, String>> userData = [
    {
      'name': 'Nguyễn Văn A',
      'birthdate': '01/01/1990',
      'hometown': 'Hà Nội',
      'image': 'https://via.placeholder.com/150', // Không có hình ảnh
    },
    {
      'name': 'Trần Thị B',
      'birthdate': '15/05/1992',
      'hometown': 'Đà Nẵng',
      'image': 'https://via.placeholder.com/150',
    },
    {
      'name': 'Trần Thị C',
      'birthdate': '15/05/1992',
      'hometown': 'Đà Nẵng',
      'image': 'https://via.placeholder.com/150',
    },
    // Bạn có thể thêm nhiều dữ liệu người dùng ở đây...
  ];

  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 30, 144, 255),
        title: const Text(
          'Kiểm tra thẻ người dùng',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                });
              },
              decoration: InputDecoration(
                hintText: 'Tìm kiếm tên người dùng...',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: const Icon(Icons.search),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 ô chữ nhật trên mỗi dòng
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.8, // Tỷ lệ chiều dài/chiều rộng của Card
          ),
          itemCount: userData
              .where((user) {
                return searchQuery.isEmpty ||
                    user['name']!.toLowerCase().contains(searchQuery);
              })
              .toList()
              .length, // Đếm số lượng thẻ phù hợp với truy vấn tìm kiếm
          itemBuilder: (context, index) {
            // Tìm kiếm dựa trên tên người dùng
            final filteredUsers = userData.where((user) {
              return searchQuery.isEmpty ||
                  user['name']!.toLowerCase().contains(searchQuery);
            }).toList();

            return UserCard(
              name: filteredUsers[index]['name']!,
              birthdate: filteredUsers[index]['birthdate']!,
              hometown: filteredUsers[index]['hometown']!,
              imageUrl: filteredUsers[index]['image'] ?? '', // Thay đổi ở đây
            );
          },
        ),
      ),
    );
  }
}
