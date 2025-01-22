import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../core/assets_manager.dart';
import '../core/routes_manager.dart';
import '../../provider/qr_code_provider.dart';

class WelcomeScan extends StatelessWidget {
  const WelcomeScan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AssetsManager.welcomeScan),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                gradient: const LinearGradient(
                  colors: [Color(0xff1A0C37), Color(0xff010510)],
                ),
              ),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, RoutesManager.qrScanRoute).then((result) {
                    if (result != null && result is String) {
                      context.read<QrCodeProvider>().setBarcode(result,context);
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  minimumSize: const Size(200, 50),
                ),
                child: Text(
                  'امسح الكود',
                  style: GoogleFonts.alexandria(
                    color: Colors.white,
                    fontSize: 20,
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
