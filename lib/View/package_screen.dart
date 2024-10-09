import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/transfer/transfer_screen.dart';
import 'package:dotted_border/dotted_border.dart';

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
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: Center(
        child: Stack(
          children: [
            // Container behind
            Positioned(
              top: 10,
              left: 10,
              child: Container(
                width: 300,
                height: 110,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
              ),
            ),
            // Main container
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                width: 300,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Shipment History',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(Icons.chevron_right,
                            size: 16, color: Colors.black),
                      ],
                    ),
                    Divider(color: Colors.grey[300]),
                    SizedBox(height: 10),
                    // Shipment item section
                    Row(
                      children: [
                        // Image
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: Colors.grey, style: BorderStyle.solid),
                          ),
                          child: Image.network(
                            'https://storage.googleapis.com/a1aa/image/gb34ouB3ZX4FLtgdghjBezLlISIiiAXyoYwwbmqLZ482bPyJA.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 10),
                        // Shipment details
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '65KL90GF48HSJ',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Confirmed - Delivery : Wed, 7 Oct',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
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

