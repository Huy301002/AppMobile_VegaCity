import 'package:flutter/material.dart';
import 'package:flutter_application_1/Component/button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isButton1Pressed = false;
  bool isButton2Pressed = false;
  bool isButton3Pressed = false;
  bool isButton4Pressed = false;
  bool isButton5Pressed = false;

  void buttonPressed(int buttonNumber) {
    setState(() {
      switch (buttonNumber) {
        case 1:
          isButton1Pressed = !isButton1Pressed;
          break;
        case 2:
          isButton2Pressed = !isButton2Pressed;
          break;
        case 3:
          isButton3Pressed = !isButton3Pressed;
          break;
        case 4:
          isButton4Pressed = !isButton4Pressed;
          break;
        case 5:
          isButton5Pressed = !isButton5Pressed;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Wrap(
          spacing: 20, // Khoảng cách giữa các nút theo chiều ngang
          runSpacing: 20, // Khoảng cách giữa các hàng
          children: [
            Button(
              onTap: () => buttonPressed(1),
              isButtonPressed: isButton1Pressed,
            ),
            Button(
              onTap: () => buttonPressed(2),
              isButtonPressed: isButton2Pressed,
            ),
            Button(
              onTap: () => buttonPressed(3),
              isButtonPressed: isButton3Pressed,
            ),
            Button(
              onTap: () => buttonPressed(4),
              isButtonPressed: isButton4Pressed,
            ),
            Button(
              onTap: () => buttonPressed(5),
              isButtonPressed: isButton5Pressed,
            ),
          ],
        ),
      ),
    );
  }
}
