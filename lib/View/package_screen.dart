import 'package:flutter/material.dart';
import 'package:flutter_application_1/Component/bottomNavbar.dart';

class PackageScreen extends StatefulWidget {
  PackageScreen({Key? key}) : super(key: key);

  @override
  _PackageScreenState createState() => _PackageScreenState();
}

class _PackageScreenState extends State<PackageScreen> {
  final List<String> imageUrls = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  ];

  final List<String> comboTitles = [
    'Combo vui chơi nước',
    'Combo vui chơi khô',
    'Combo trọn gói',
    'Combo hè thả ga',
  ];

  final List<String> comboDetails = [
    '_ Combo kèm gói vui chơi mọi trò chơi ở khu vực nước\n'
        '_ Kèm theo ăn uống trọn gói\n'
        '_ Sử dụng dịch vụ free\n'
        '_ Không áp dụng ngoài khu vực nước',
    '_ Combo kèm gói vui chơi mọi trò chơi ở khu vực khô\n'
        '_ Kèm theo ăn uống trọn gói\n'
        '_ Sử dụng dịch vụ free\n'
        '_ Không áp dụng ngoài khu vực khô',
    '_ Combo kèm gói vui chơi mọi trò chơi ở khu vực khô lẫn nước\n'
        '_ Kèm theo ăn uống trọn gói\n'
        '_ Sử dụng dịch vụ free',
    '_ Giảm 25% áp dụng cho mọi chương trình trong dịp hè',
  ];

  String selectedFilter = 'All'; // Bộ lọc mặc định

  List<int> getFilteredIndexes() {
    if (selectedFilter == 'All') {
      return List.generate(comboTitles.length, (index) => index);
    } else if (selectedFilter == 'Nước') {
      return [0];
    } else if (selectedFilter == 'Khô') {
      return [1];
    } else if (selectedFilter == 'Khuyến mãi khác') {
      return [3];
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    List<int> filteredIndexes = getFilteredIndexes();

    return Scaffold(
      backgroundColor: const Color(0xFFD6E2EA),
      appBar: AppBar(
        title: Text('Popup Card Demo'),
        centerTitle: true,
        leading: Container(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      selectedFilter = 'All';
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide.none, // Loại bỏ viền
                    backgroundColor: selectedFilter == 'All'
                        ? Colors.blue
                        : Colors.white, // Màu nền khi không chọn là màu trắng
                    primary: selectedFilter == 'All'
                        ? Colors.white
                        : Colors.black, // Màu chữ thay đổi theo trạng thái
                  ),
                  child: Text('All'),
                ),
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      selectedFilter = 'Nước';
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide.none, // Loại bỏ viền
                    backgroundColor: selectedFilter == 'Nước'
                        ? Colors.blue
                        : Colors.white, // Màu nền khi không chọn là màu trắng
                    primary: selectedFilter == 'Nước'
                        ? Colors.white
                        : Colors.black, // Màu chữ thay đổi theo trạng thái
                  ),
                  child: Text('Nước'),
                ),
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      selectedFilter = 'Khô';
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide.none, // Loại bỏ viền
                    backgroundColor: selectedFilter == 'Khô'
                        ? Colors.blue
                        : Colors.white, // Màu nền khi không chọn là màu trắng
                    primary: selectedFilter == 'Khô'
                        ? Colors.white
                        : Colors.black, // Màu chữ thay đổi theo trạng thái
                  ),
                  child: Text('Khô'),
                ),
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      selectedFilter = 'Khuyến mãi khác';
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide.none, // Loại bỏ viền
                    backgroundColor: selectedFilter == 'Khuyến mãi khác'
                        ? Colors.blue
                        : Colors.white, // Màu nền khi không chọn là màu trắng
                    primary: selectedFilter == 'Khuyến mãi khác'
                        ? Colors.white
                        : Colors.black, // Màu chữ thay đổi theo trạng thái
                  ),
                  child: Text('Khuyến mãi'),
                ),
              ],
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 1.5,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: filteredIndexes.length,
                itemBuilder: (BuildContext context, int index) {
                  int filteredIndex = filteredIndexes[index];
                  return GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            title: Text(
                              comboTitles[filteredIndex],
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(comboDetails[filteredIndex]),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        showModalBottomSheet(
                                          context: context,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(20),
                                            ),
                                          ),
                                          builder: (BuildContext context) {
                                            return Container(
                                              padding: EdgeInsets.all(16),
                                              height: 200,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text('Combo Details'),
                                                  SizedBox(height: 10),
                                                  Text(
                                                      'This is your card code: ABC123'),
                                                  SizedBox(height: 20),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text('Close'),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: Text('Order'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('Close'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 5,
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                            child: Image.network(
                              imageUrls[filteredIndex],
                              height: 180,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 10.0, bottom: 10.0),
                            child: Text(
                              comboTitles[filteredIndex],
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 1,
        onTap: (index) {},
      ),
    );
  }
}
