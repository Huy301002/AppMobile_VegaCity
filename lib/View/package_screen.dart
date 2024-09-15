import 'package:flutter/material.dart';

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Package'),
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
                    backgroundColor: selectedFilter == 'All'
                        ? Color.fromARGB(255, 30, 144, 255)
                        : Colors.white,
                    foregroundColor:
                        selectedFilter == 'All' ? Colors.white : Colors.black,
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
                    backgroundColor: selectedFilter == 'Nước'
                        ? Color.fromARGB(255, 30, 144, 255)
                        : Colors.white,
                    foregroundColor:
                        selectedFilter == 'Nước' ? Colors.white : Colors.black,
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
                    backgroundColor: selectedFilter == 'Khô'
                        ? Color.fromARGB(255, 30, 144, 255)
                        : Colors.white,
                    foregroundColor:
                        selectedFilter == 'Khô' ? Colors.white : Colors.black,
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
                    backgroundColor: selectedFilter == 'Khuyến mãi khác'
                        ? Color.fromARGB(255, 30, 144, 255)
                        : Colors.white,
                    foregroundColor: selectedFilter == 'Khuyến mãi khác'
                        ? Colors.white
                        : Colors.black,
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
                              borderRadius: BorderRadius.circular(5),
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
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
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                        ),
                                        onPressed: () {
                                          showModalBottomSheet(
                                            context: context,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            builder: (BuildContext context) {
                                              return Container(
                                                padding: EdgeInsets.all(16),
                                                height: 450,
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    DropdownButtonFormField<
                                                        String>(
                                                      decoration:
                                                          InputDecoration(
                                                        labelText: 'Zone',
                                                        border:
                                                            OutlineInputBorder(),
                                                      ),
                                                      items: [
                                                        'Zone A',
                                                        'Zone B',
                                                        'Zone C'
                                                      ].map((String zone) {
                                                        return DropdownMenuItem<
                                                            String>(
                                                          value: zone,
                                                          child: Text(zone),
                                                        );
                                                      }).toList(),
                                                      onChanged:
                                                          (String? newValue) {
                                                        print(newValue);
                                                      },
                                                      validator: (value) {
                                                        if (value == null ||
                                                            value.isEmpty) {
                                                          return 'Please select a zone';
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                    SizedBox(height: 10),
                                                    TextFormField(
                                                      decoration:
                                                          InputDecoration(
                                                        labelText: 'Số tiền',
                                                        border:
                                                            OutlineInputBorder(),
                                                      ),
                                                      keyboardType:
                                                          TextInputType.number,
                                                    ),
                                                    SizedBox(height: 10),
                                                    TextFormField(
                                                      decoration:
                                                          InputDecoration(
                                                        labelText: 'Số lượng',
                                                        border:
                                                            OutlineInputBorder(),
                                                      ),
                                                      keyboardType:
                                                          TextInputType.number,
                                                    ),
                                                    SizedBox(height: 20),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        gradient:
                                                            LinearGradient(
                                                          colors: [
                                                            Color.fromARGB(255,
                                                                30, 144, 255),
                                                            Color.fromARGB(255,
                                                                16, 78, 139),
                                                          ],
                                                          begin:
                                                              Alignment.topLeft,
                                                          end: Alignment
                                                              .bottomRight,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      child: ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          shadowColor: Colors
                                                              .transparent,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                          ),
                                                        ),
                                                        onPressed: () {
                                                          // Code hành động cho nút
                                                        },
                                                        child: Text(
                                                          'General E-tag',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        child: Text(
                                          'General E-tag',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
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
                    },
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            imageUrls[filteredIndex],
                            height: 150,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  comboTitles[filteredIndex],
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
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
            ),
          ],
        ),
      ),
    );
  }
}
