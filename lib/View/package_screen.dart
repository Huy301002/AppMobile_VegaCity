import 'package:flutter/material.dart';

class PackageScreen extends StatefulWidget {
  const PackageScreen({Key? key}) : super(key: key);

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
    'Combo kèm gói vui chơi mọi trò chơi ở khu vực nước\nKèm theo ăn uống trọn gói\nSử dụng dịch vụ free\nKhông áp dụng ngoài khu vực nước',
    'Combo kèm gói vui chơi mọi trò chơi ở khu vực khô\nKèm theo ăn uống trọn gói\nSử dụng dịch vụ free\nKhông áp dụng ngoài khu vực khô',
    'Combo kèm gói vui chơi mọi trò chơi ở khu vực khô lẫn nước\nKèm theo ăn uống trọn gói\nSử dụng dịch vụ free',
    'Giảm 25% áp dụng cho mọi chương trình trong dịp hè',
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

  void _showDetailsDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          title: Text(
            comboTitles[index],
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(comboDetails[index]),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromARGB(255, 30, 144, 255),
                          Color.fromARGB(255, 16, 78, 139),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context); // Đóng hộp thoại hiện tại
                        _showBookingBottomSheet(context);
                      },
                      child: const Text('Đặt ngay'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _showBookingBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          height: 450,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Zone',
                  border: OutlineInputBorder(),
                ),
                items: ['Zone A', 'Zone B', 'Zone C'].map((String zone) {
                  return DropdownMenuItem<String>(
                    value: zone,
                    child: Text(zone),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  print(newValue);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a zone';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              const Text(
                'Chọn Zone để biết thêm chi tiết!',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<int> filteredIndexes = getFilteredIndexes();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 30, 144, 255),
        title: const Text(
          'Package',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: Container(),
      ),
      body: SingleChildScrollView(
        child: Padding(
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
                      backgroundColor: selectedFilter == 'All'
                          ? const Color.fromARGB(255, 30, 144, 255)
                          : Colors.white,
                      foregroundColor:
                          selectedFilter == 'All' ? Colors.white : Colors.black,
                    ),
                    child: const Text('All'),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      setState(() {
                        selectedFilter = 'Nước';
                      });
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: selectedFilter == 'Nước'
                          ? const Color.fromARGB(255, 30, 144, 255)
                          : Colors.white,
                      foregroundColor: selectedFilter == 'Nước'
                          ? Colors.white
                          : Colors.black,
                    ),
                    child: const Text('Nước'),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      setState(() {
                        selectedFilter = 'Khô';
                      });
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: selectedFilter == 'Khô'
                          ? const Color.fromARGB(255, 30, 144, 255)
                          : Colors.white,
                      foregroundColor:
                          selectedFilter == 'Khô' ? Colors.white : Colors.black,
                    ),
                    child: const Text('Khô'),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      setState(() {
                        selectedFilter = 'Khuyến mãi khác';
                      });
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: selectedFilter == 'Khuyến mãi khác'
                          ? const Color.fromARGB(255, 30, 144, 255)
                          : Colors.white,
                      foregroundColor: selectedFilter == 'Khuyến mãi khác'
                          ? Colors.white
                          : Colors.black,
                    ),
                    child: const Text('Khuyến mãi'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Column(
                children: filteredIndexes.map((index) {
                  return GestureDetector(
                    onTap: () {
                      _showDetailsDialog(context, index);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(
                          bottom: 16), // Thêm khoảng cách dưới mỗi card
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.horizontal(
                                      left: Radius.circular(10)),
                                  image: DecorationImage(
                                    image: NetworkImage(imageUrls[index]),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                height: 150, // Chiều cao hình ảnh
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      comboTitles[index],
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      comboDetails[index],
                                      maxLines: 3, // Hiển thị tối đa 3 dòng
                                      overflow: TextOverflow
                                          .ellipsis, // Hiển thị ... nếu có nhiều hơn 3 dòng
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
