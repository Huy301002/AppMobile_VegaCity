import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/e_tag/card.dart';

class ActiveUsers extends StatefulWidget {
  final List<Map<String, String>> userData;
  const ActiveUsers({Key? key, required this.userData}) : super(key: key);

  @override
  _ActiveUsersState createState() => _ActiveUsersState();
}

class _ActiveUsersState extends State<ActiveUsers> {
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Column(
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
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.62,
              ),
              itemCount: widget.userData
                  .where((user) {
                    return searchQuery.isEmpty ||
                        user['name']!.toLowerCase().contains(searchQuery);
                  })
                  .toList()
                  .length,
              itemBuilder: (context, index) {
                final filteredUsers = widget.userData.where((user) {
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
                              Image.network(filteredUsers[index]['image'] ?? '',
                                  height: 100, width: 100, fit: BoxFit.cover),
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
    );
  }
}
