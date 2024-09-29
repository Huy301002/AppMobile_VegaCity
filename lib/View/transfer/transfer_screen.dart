import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/transfer/bank_bottom_sheet.dart';
import 'package:flutter_application_1/View/transfer/transfer_details.dart';
import 'search_bottom_sheet.dart';
import 'friends_bottom_sheet.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  String inputDisplay = "0đ"; // Đặt giá trị mặc định là "0"
  String inputNumber = "";
  String? selectedZone;

  // Tạo danh sách để quản lý trạng thái nhấn của các nút
  List<bool> isPressed = List.generate(12, (index) => false);

  // Controller để quản lý TextField
  final TextEditingController _controller = TextEditingController();

  // Biến để kiểm soát hiển thị bàn phím
  bool showCustomKeyboard = true;

  @override
  void initState() {
    super.initState();
    _controller.text = inputDisplay;
  }

  String _formatNumber(String number) {
    // Chuyển đổi chuỗi số thành định dạng có dấu chấm
    StringBuffer formattedNumber = StringBuffer();
    int length = number.length;
    for (int i = 0; i < length; i++) {
      if (i > 0 && (length - i) % 3 == 0) {
        formattedNumber.write('.');
      }
      formattedNumber.write(number[i]);
    }
    return formattedNumber.toString();
  }

  void _updateDisplay(String newText) {
    setState(() {
      if (inputDisplay == "0đ" && newText != "00" && newText != "000") {
        inputNumber = newText; // Cập nhật inputNumber
        inputDisplay =
            _formatNumber(inputNumber) + "đ"; // Định dạng và thêm đơn vị
      } else {
        inputNumber += newText; // Cập nhật inputNumber
        inputDisplay =
            _formatNumber(inputNumber) + "đ"; // Định dạng và thêm đơn vị
      }
      _controller.text = inputDisplay;
    });
  }

  void _removeLastCharacter() {
    setState(() {
      if (inputNumber.isNotEmpty) {
        inputNumber =
            inputNumber.substring(0, inputNumber.length - 1); // Xóa ký tự cuối
        inputDisplay = inputNumber.isEmpty
            ? "0đ"
            : _formatNumber(inputNumber) + "đ"; // Định dạng lại
      } else {
        inputDisplay = "0đ";
      }
      _controller.text = inputDisplay;
    });
  }

  // Hàm để mở BottomSheet
  void _showBottomSheet(Widget bottomSheetContent) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return bottomSheetContent;
      },
    );
  }

  void _onZoneSelected(String zone) {
    setState(() {
      selectedZone = zone; // Lưu khu vực đã chọn
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 160), // Đẩy nội dung xuống một chút
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.transparent),
              ),
              child: Center(
                child: TextField(
                  controller: _controller,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.blue, fontSize: 50),
                  cursorColor: Colors.blue,
                  showCursor: true,
                  readOnly: true, // Đặt ô nhập chỉ đọc
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  onTap: () {
                    // Khi người dùng bấm vào ô này, ẩn bàn phím tùy chỉnh và hiện bàn phím số
                    setState(() {
                      showCustomKeyboard = true; // Hiện bàn phím số
                    });
                  },
                ),
              ),
            ),
            // Ô nhập nội dung
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.transparent),
              ),
              child: Center(
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      inputNumber = value;
                    });
                  },
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.blue, fontSize: 20),
                  cursorColor: Colors.blue, // Màu thanh nhấp nháy
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Nội dung cần chuyển', // Placeholder
                    hintStyle:
                        TextStyle(color: Colors.grey), // Màu chữ placeholder
                  ),
                  onTap: () {
                    // Khi người dùng bấm vào ô này, ẩn bàn phím tùy chỉnh
                    setState(() {
                      showCustomKeyboard = false; // Ẩn bàn phím số
                    });
                  },
                ),
              ),
            ),
            const Divider(
              color: Colors.grey, // Màu của đường kẻ
              thickness: 1, // Độ dày của đường kẻ
              indent: 110, // Khoảng cách từ lề trái
              endIndent: 110, // Khoảng cách từ lề phải
            ),
            const SizedBox(height: 60),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Chọn người chuyển',
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                ),
              ],
            ),
            // Phần chọn người chuyển
            if (selectedZone == null) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.start, // Đặt giữa màn hình
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0, top: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.search, color: Colors.blue),
                          onPressed: () {
                            _showBottomSheet(
                              SearchBottomSheet(
                                onZoneSelected: _onZoneSelected,
                              ),
                            );
                          },
                        ),
                        const Text('Tìm kiếm',
                            style: TextStyle(color: Colors.black)),
                      ],
                    ),
                  ),
                  const SizedBox(width: 30), // Khoảng cách giữa các icon
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.account_balance_outlined,
                              color: Colors.blue),
                          onPressed: () {
                            _showBottomSheet(const BankBottomSheet());
                          },
                        ),
                        const Text('Ngân hàng',
                            style: TextStyle(color: Colors.black)),
                      ],
                    ),
                  ),
                  const SizedBox(width: 30), // Khoảng cách giữa các icon
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.person_outline,
                              color: Colors.blue),
                          onPressed: () {
                            _showBottomSheet(const FriendsBottomSheet());
                          },
                        ),
                        const Text('Bạn bè',
                            style: TextStyle(color: Colors.black)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20), // Khoảng cách giữa 2 hàng
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child: Column(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.add_circle_outline,
                              color: Colors.blue),
                          onPressed: () {
                            // Logic cho nút dấu cộng
                          },
                        ),
                        const Text('Thêm',
                            style: TextStyle(color: Colors.black)),
                      ],
                    ),
                  ),
                ],
              ),
            ] else ...[
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  width: 365,
                  height: 70,
                  padding: const EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.grey), // Đường viền hình chữ nhật
                    borderRadius:
                        BorderRadius.circular(8), // Bo góc cho hình chữ nhật
                    color: Colors.white, // Màu nền nhạt
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceBetween, // Căn chỉnh không gian giữa các phần tử
                    children: [
                      // Hiển thị khu vực đã chọn
                      Text(
                        'Khu vực đã chọn: $selectedZone',
                        style: const TextStyle(fontSize: 18),
                      ),
                      // Nút hủy chọn (IconButton với icon cancel)
                      IconButton(
                        icon: const Icon(Icons.cancel, color: Colors.grey),
                        onPressed: () {
                          setState(() {
                            selectedZone = null; // Xóa lựa chọn khu vực
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                  height: 20), // Khoảng cách giữa ô viền và nút tiếp tục
              SizedBox(
                width: 365,
                height: 50,
                child: MaterialButton(
                  minWidth: double.infinity,
                  color: const Color.fromARGB(255, 30, 144, 255),
                  height: 60,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const TransferDetails()), // Đảm bảo rằng TransferDetails là widget đúng
                    );
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  child: const Text(
                    "tiếp tục",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
            const Spacer(),
            if (showCustomKeyboard) // Chỉ hiển thị bàn phím tùy chỉnh nếu biến này là true
              Container(
                color: Colors.grey[50],
                child: SizedBox(
                  height: 300,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: GridView.builder(
                      itemCount: 12,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisExtent: 60,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 35,
                      ),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTapDown: (_) {
                            // Khi nhấn xuống
                            setState(() {
                              isPressed[index] = true;
                            });
                          },
                          onTapUp: (_) {
                            // Khi thả nút
                            setState(() {
                              isPressed[index] = false;
                            });
                          },
                          onTap: () {
                            // Logic khi nhấn nút
                            String newText = "";
                            if (index == 9) {
                              _removeLastCharacter();
                            } else if (index == 10) {
                              newText = "00";
                            } else if (index == 11) {
                              newText = "000";
                            } else {
                              newText = (index + 1).toString();
                            }
                            if (index != 9) {
                              _updateDisplay(newText);
                            }
                            setState(() {});
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[50], // Màu nền của nút
                              border: Border.all(color: Colors.transparent),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(30)),
                              // Thêm boxShadow khi nút được nhấn
                              boxShadow: isPressed[index]
                                  ? [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: const Offset(2, 3),
                                      ),
                                    ]
                                  : [],
                            ),
                            child: Center(
                              child: Text(
                                index == 9
                                    ? "⌫"
                                    : index == 10
                                        ? "00"
                                        : index == 11
                                            ? "000"
                                            : "${index + 1}",
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.blue),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
