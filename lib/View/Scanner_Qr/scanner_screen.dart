import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/Scanner_Qr/scanner_result.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_scanner_overlay/qr_scanner_overlay.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  bool isFlashOn = false;
  bool isFrontCamera = false;
  bool isScanCompleted = false;
  MobileScannerController cameraController = MobileScannerController();

  void closeScreen() {
    isScanCompleted = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber.shade900,
        title: const Text(
          'Scanner',
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
            onPressed: () {},
            icon: Icon(Icons.qr_code_scanner)),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isFlashOn = !isFlashOn;
              });
              cameraController.toggleTorch();
            },
            icon: Icon(Icons.flash_on,
                color: isFlashOn ? Colors.white : Colors.black),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                isFrontCamera = !isFrontCamera;
              });
              cameraController.switchCamera();
            },
            icon: Icon(Icons.flip_camera_android,
                color: isFrontCamera ? Colors.white : Colors.black),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Place the QR code in designated area",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                  Text(
                    "Let the scan do the magic-it starts on its own!",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              flex: 2,
              child: Stack(children: [
                MobileScanner(
                    controller: cameraController,
                    allowDuplicates: true,
                    onDetect: (barcode, args) {
                      if (!isScanCompleted) {
                        isScanCompleted = true;
                        String code = barcode.rawValue ?? "---";
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return QRResult(
                            code: code,
                            closeScreen: closeScreen,
                          );
                        }));
                      }
                    }),
                QRScannerOverlay(
                  overlayColor: Colors.black26,
                  borderColor: Colors.amber.shade900,
                  borderRadius: 20,
                  borderStrokeWidth: 10,
                  scanAreaHeight: 250,
                  scanAreaWidth: 250,
                )
              ]),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "!Scan properly to see results!",
                    style: TextStyle(
                      color: Colors.amber.shade900,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
