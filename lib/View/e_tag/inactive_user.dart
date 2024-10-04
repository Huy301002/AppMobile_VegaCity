import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/e_tag/card.dart';

class InactiveUsers extends StatefulWidget {
  final List<Map<String, String>> userData;
  const InactiveUsers({Key? key, required this.userData}) : super(key: key);

  @override
  _InactiveUsersState createState() => _InactiveUsersState();
}

class _InactiveUsersState extends State<InactiveUsers> {
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = '';
  List<Map<String, String>> _userData = [];

  @override
  void initState() {
    super.initState();
    _userData = List.from(widget.userData); // Sao chép dữ liệu ban đầu
  }

  // Hàm để xóa tất cả người dùng và hiển thị thông báo
  void _resetAllData() {
    setState(() {
      _userData.clear(); // Xóa tất cả dữ liệu
    });

    // Hiển thị Snackbar thông báo
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Đã reset lại thẻ người dùng'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
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
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: const Icon(Icons.search),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.62,
                    ),
                    itemCount: _userData
                        .where((user) {
                          return searchQuery.isEmpty ||
                              user['name']!.toLowerCase().contains(searchQuery);
                        })
                        .toList()
                        .length,
                    itemBuilder: (context, index) {
                      final filteredUsers = _userData.where((user) {
                        return searchQuery.isEmpty ||
                            user['name']!.toLowerCase().contains(searchQuery);
                      }).toList();

                      return GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.network(
                                        filteredUsers[index]['image'] ?? '',
                                        height: 100,
                                        width: 100,
                                        fit: BoxFit.cover),
                                    const SizedBox(height: 10),
                                    Text(filteredUsers[index]['name']!,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16)),
                                    Text(
                                        'Ngày sinh: ${filteredUsers[index]['birthdate']}'),
                                    Text(
                                        'Quê quán: ${filteredUsers[index]['hometown']}'),
                                    Text(
                                        'NPH: ${filteredUsers[index]['startDate'] ?? 'null'}'),
                                    Text(
                                        'HSD: ${filteredUsers[index]['endDate'] ?? 'null'}'),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Đóng'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: UserCard(
                          name: filteredUsers[index]['name']!,
                          birthdate: filteredUsers[index]['birthdate']!,
                          hometown: filteredUsers[index]['hometown']!,
                          imageUrl: filteredUsers[index]['image'] ?? '',
                          startDate: filteredUsers[index]['startDate'] ?? '',
                          endDate: filteredUsers[index]['endDate'] ?? '',
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              onPressed: () {
                _resetAllData(); // Xóa tất cả dữ liệu khi nhấn nút và hiển thị thông báo
              },
              backgroundColor: Colors.blue[50],
              child: const Icon(Icons.refresh),
            ),
          ),
        ],
      ),
    );
  }
}
