import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/transfer/transfer_screen.dart';

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
    'Combo chơi nước',
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

  final List<String> comboPrices = [
    '\100đ',
    '\80đ',
    '\120đ',
    '\25đ',
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 30, 144, 255),
        title: const Text(
          'Package',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: Container(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                height: 50,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          setState(() {
                            selectedFilter = 'All';
                          });
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: selectedFilter == 'All'
                              ? Colors.white
                              : Colors.blue, // Màu chữ
                          backgroundColor: selectedFilter == 'All'
                              ? Colors.blue
                              : Colors.white, // Màu nền
                          side: BorderSide(
                            color: selectedFilter == 'All'
                                ? Colors.blue
                                : Colors.grey,
                          ),
                        ),
                        child: Text('All'),
                      ),
                      const SizedBox(width: 8),
                      OutlinedButton(
                        onPressed: () {
                          setState(() {
                            selectedFilter = 'Khô';
                          });
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: selectedFilter == 'Khô'
                              ? Colors.white
                              : Colors.blue, // Màu chữ
                          backgroundColor: selectedFilter == 'Khô'
                              ? Colors.blue
                              : Colors.white, // Màu nền
                          side: BorderSide(
                            color: selectedFilter == 'Khô'
                                ? Colors.blue
                                : Colors.grey,
                          ),
                        ),
                        child: Text('Khô'),
                      ),
                      const SizedBox(width: 8),
                      OutlinedButton(
                        onPressed: () {
                          setState(() {
                            selectedFilter = 'Nước';
                          });
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: selectedFilter == 'Nước'
                              ? Colors.white
                              : Colors.blue, // Màu chữ
                          backgroundColor: selectedFilter == 'Nước'
                              ? Colors.blue
                              : Colors.white, // Màu nền
                          side: BorderSide(
                            color: selectedFilter == 'Nước'
                                ? Colors.blue
                                : Colors.grey,
                          ),
                        ),
                        child: Text('Nước'),
                      ),
                      const SizedBox(width: 8),
                      OutlinedButton(
                        onPressed: () {
                          setState(() {
                            selectedFilter = 'Khuyến mãi khác';
                          });
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: selectedFilter == 'Khuyến mãi khác'
                              ? Colors.white
                              : Colors.blue, // Màu chữ
                          backgroundColor: selectedFilter == 'Khuyến mãi khác'
                              ? Colors.blue
                              : Colors.white, // Màu nền
                          side: BorderSide(
                            color: selectedFilter == 'Khuyến mãi khác'
                                ? Colors.blue
                                : Colors.grey,
                          ),
                        ),
                        child: Text('Khuyến mãi khác'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.65),
                itemCount: filteredIndexes.length,
                itemBuilder: (context, index) {
                  int actualIndex = filteredIndexes[index];
                  return GestureDetector(
                    onTap: () {
                      _showDetailsDialog(context, actualIndex);
                    },
                    child: Card(
                      color: Colors.white,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 150,
                            width: double.infinity,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                imageUrls[actualIndex],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  comboTitles[actualIndex],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${comboDetails[actualIndex].split('\n').first}...',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  comboPrices[actualIndex],
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
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
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TransferScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                      child: const Text(
                        'General E-tag',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
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

  // void _showBookingBottomSheet(BuildContext context, int index) {
  //   showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
  //     ),
  //     builder: (BuildContext context) {
  //       return Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  //         child: Wrap(
  //           children: [
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Text(
  //                   comboTitles[index],
  //                   style: const TextStyle(
  //                       fontSize: 20, fontWeight: FontWeight.bold),
  //                 ),
  //                 IconButton(
  //                   onPressed: () {
  //                     Navigator.pop(context);
  //                   },
  //                   icon: const Icon(Icons.close),
  //                 ),
  //               ],
  //             ),
  //             const SizedBox(height: 10),
  //             Text(
  //               comboDetails[index],
  //               style: const TextStyle(fontSize: 16),
  //             ),
  //             const SizedBox(height: 20),
  //             ElevatedButton(
  //               onPressed: () {
  //                 // Thêm logic xử lý đặt E-tag
  //                 Navigator.pop(context);
  //               },
  //               style: ElevatedButton.styleFrom(
  //                 padding: const EdgeInsets.symmetric(vertical: 15),
  //                 backgroundColor: Colors.blue,
  //               ),
  //               child: const Center(
  //                 child: Text('Book Now', style: TextStyle(fontSize: 18)),
  //               ),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }
}
