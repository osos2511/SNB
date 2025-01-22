import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import '../../provider/qr_code_provider.dart';

class QrCodeScanner extends StatefulWidget {
  const QrCodeScanner({super.key});

  @override
  State<QrCodeScanner> createState() => _QrCodeScannerState();
}

class _QrCodeScannerState extends State<QrCodeScanner> {
  @override
  void initState() {
    super.initState();
    Provider.of<QrCodeProvider>(context, listen: false).resetScan();
  }

  @override
  Widget build(BuildContext context) {
    final qrCodeProvider = Provider.of<QrCodeProvider>(context);

    return Scaffold(
      body: Stack(
        children: [
          MobileScanner(
            fit: BoxFit.cover,
            onDetect: (BarcodeCapture capture) {
              final List<Barcode> barcodes = capture.barcodes;
              final String? code = barcodes.isNotEmpty ? barcodes.first.rawValue : null;

              if (code != null && !qrCodeProvider.isScanned) {
                qrCodeProvider.setBarcode(code, context);
              } else {
                print("No barcode detected");
              }
            },
          ),
          Center(
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.blue,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: const Text(
              "Place the barcode inside the box",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}