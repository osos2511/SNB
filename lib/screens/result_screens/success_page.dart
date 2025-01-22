import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'تم تسجيل الدخول بنجاح',
              style: GoogleFonts.alexandria(
                fontWeight: FontWeight.w400,
                fontSize: screenWidth * 0.08,
                color: const Color(0xFF1A0C37),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: screenHeight * 0.05),
            Center(
              child: Lottie.asset(
                'assets/lottie/Animation - 1737382485453.json',
                width: screenWidth * 0.8,
                height: screenHeight * 0.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
