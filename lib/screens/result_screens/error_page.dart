import 'package:flutter/material.dart';
import 'package:gallary_system/core/routes_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../provider/qr_code_provider.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.read<QrCodeProvider>().resetScan();
            Navigator.pushReplacementNamed(context, RoutesManager.welcomeScanRoute);

          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'الحساب غير مسجل',
              style: GoogleFonts.alexandria(
                fontWeight: FontWeight.w400,
                fontSize: screenWidth * 0.08,
                color: const Color(0xFF1A0C37),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: screenHeight * 0.1),
            Center(
              child: Lottie.asset(
                'assets/lottie/Animation - 1737382578445.json',
                width: screenWidth * 0.7,
                height: screenHeight * 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
