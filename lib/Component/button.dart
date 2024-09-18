import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final onTap;
  final bool isButtonPressed;
  final Color buttonColor;
  final IconData icon;
  final String label;

  const Button({
    Key? key,
    required this.onTap,
    required this.isButtonPressed,
    required this.buttonColor,
    required this.icon,
    required this.label, // Thêm tham số label
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          color: isButtonPressed
              ? buttonColor.withOpacity(0.6)
              : buttonColor.withOpacity(0.3),
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade500,
              offset: const Offset(6, 6),
              blurRadius: 15,
              spreadRadius: 1,
            ),
            const BoxShadow(
              color: Colors.white,
              offset: Offset(-6, -6),
              blurRadius: 15,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 60,
              color:
                  isButtonPressed ? buttonColor.withOpacity(0.8) : buttonColor,
            ),
            const SizedBox(height: 8), // Khoảng cách giữa icon và text
            Text(
              label,
              style: TextStyle(
                color: isButtonPressed
                    ? buttonColor.withOpacity(0.8)
                    : buttonColor,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
