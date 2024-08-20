import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final onTap;
  bool isButtonPressed;
  Button({this.onTap, required this.isButtonPressed});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100,
        width: 100,
        child: Icon(
          Icons.wallet,
          size: 60,
          color: Colors.grey[400],
        ),
        decoration: BoxDecoration(
          color:
              isButtonPressed ? Colors.blue : Color.fromARGB(255, 19, 160, 226),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade500,
              offset: Offset(6, 6),
              blurRadius: 15,
              spreadRadius: 1,
            ),
            BoxShadow(
              color: Colors.white,
              offset: Offset(-6, -6),
              blurRadius: 15,
              spreadRadius: 1,
            ),
          ],
        ),
      ),
    );
  }
}
