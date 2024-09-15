import 'package:flutter/material.dart';

class QRResult extends StatelessWidget {
  final String code;
  final Function() closeScreen;
  const QRResult({
    super.key,
    required this.code,
    required this.closeScreen,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber.shade900,
        title: const Text(
          'Scanner Result',
          style: TextStyle(
            color: Colors.white,
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          style: ButtonStyle(
            iconSize: MaterialStatePropertyAll(30),
            iconColor: MaterialStatePropertyAll(Colors.amber.shade900),
            backgroundColor: MaterialStatePropertyAll(Colors.white70),
          ),
          onPressed: closeScreen,
          icon: const Icon(Icons.qr_code_scanner),
        ),
      ),
    );
  }
}
