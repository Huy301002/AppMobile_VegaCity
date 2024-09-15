import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/View/Scanner_Qr/scanner_screen.dart';
import 'package:qr_flutter/qr_flutter.dart';

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
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ScannerScreen();
            }));
          },
          icon: const Icon(Icons.qr_code_scanner),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(60),
        child: Column(
          children: [
            SizedBox(
              height: 120,
            ),
            QrImageView(
              data: "data",
              size: 300,
              version: QrVersions.auto,
            ),
            Text(
              "Scanned QR",
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              code,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 150,
              height: 60,
              child: ElevatedButton(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: code));
                  },
                  child: Text("Copy")),
            )
          ],
        ),
      ),
    );
  }
}
