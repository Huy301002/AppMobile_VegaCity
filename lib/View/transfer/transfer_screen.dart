import 'package:flutter/material.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  String inputDisplay = "0"; // Đặt giá trị mặc định là "0"
  String inputNumber = "";

  // Tạo danh sách để quản lý trạng thái nhấn của các nút
  List<bool> isPressed = List.generate(12, (index) => false);

  // Controller để quản lý TextField
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = inputDisplay; // Đặt giá trị mặc định cho controller
  }

  void _updateDisplay(String newText) {
    setState(() {
      if (inputDisplay == "0" && newText != "00" && newText != "000") {
        inputDisplay = newText;
      } else {
        inputDisplay += newText;
      }
      _controller.text = inputDisplay;
    });
  }

  void _removeLastCharacter() {
    setState(() {
      if (inputDisplay.length > 1) {
        inputDisplay = inputDisplay.substring(0, inputDisplay.length - 1);
      } else {
        inputDisplay = "0";
      }
      _controller.text = inputDisplay;
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
                  style: TextStyle(color: Colors.blue, fontSize: 20),
                  cursorColor: Colors.blue, // Màu thanh nhấp nháy
                  showCursor: true,
                  readOnly: true, // Đặt ô nhập chỉ đọc
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Text(
              "Số tiền chuyển $inputNumber",
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
            const Spacer(), // Đẩy nội dung bàn phím xuống sát đáy
            Container(
              child: SizedBox(
                height: 320, // Đặt chiều cao của bàn phím
                width: 350,
                child: GridView.builder(
                  itemCount: 12,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                          color: Colors.white, // Màu nền của nút
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
          ],
        ),
      ),
    );
  }
}
