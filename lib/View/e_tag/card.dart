import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final String name;
  final String birthdate;
  final String amount;
  final String imageUrl;
  final String startDate;
  final String endDate;
  final String eTag;

  const UserCard({
    Key? key,
    required this.name,
    required this.birthdate,
    required this.amount,
    required this.imageUrl,
    required this.startDate,
    required this.endDate,
    required this.eTag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // Bỏ chiều cao cố định
      width: double.infinity, // Chiều rộng mở rộng hết màn hình
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start, // Căn chỉnh ở đầu
            children: [
              // Phần hình ảnh người dùng bên trái
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: imageUrl.isNotEmpty
                    ? Image.network(
                        imageUrl,
                        height: 100, // Chiều cao hình ảnh
                        width: 100, // Chiều rộng hình ảnh
                        fit: BoxFit.cover,
                      )
                    : Container(
                        height: 100,
                        width: 100,
                        color: Colors.grey[300],
                        child: const Icon(
                          Icons.person,
                          size: 50,
                          color: Colors.white,
                        ),
                      ),
              ),
              const SizedBox(width: 16),
              // Phần thông tin người dùng bên phải
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Hiển thị mã eTag
                    Text(
                      'Mã eTag: $eTag',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Hiển thị tên người dùng
                    Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Ngày sinh
                    Text(
                      'Ngày sinh: $birthdate',
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    // Quê quán
                    Text(
                      'Số tiền: $amount',
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    // NPH và HSD
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'NPH: ${startDate.isNotEmpty ? startDate : 'Không có dữ liệu'}',
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'HSD: ${endDate.isNotEmpty ? endDate : 'Không có dữ liệu'}',
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserCardList extends StatelessWidget {
  final List<Map<String, String>> filteredUsers;

  const UserCardList({Key? key, required this.filteredUsers}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách người dùng'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 10),
        itemCount: filteredUsers.length,
        itemBuilder: (context, index) {
          return UserCard(
            name: filteredUsers[index]['name'] ?? 'Tên không xác định',
            birthdate:
                filteredUsers[index]['birthdate'] ?? 'Không rõ ngày sinh',
            amount: filteredUsers[index]['amount'] ?? 'Không rõ quê quán',
            imageUrl: filteredUsers[index]['image'] ??
                'https://via.placeholder.com/150',
            startDate: filteredUsers[index]['startDate'] ?? 'Không rõ NPH',
            endDate: filteredUsers[index]['endDate'] ?? 'Không rõ HSD',
            eTag: filteredUsers[index]['eTag'] ?? 'Không có eTag',
          );
        },
      ),
    );
  }
}
