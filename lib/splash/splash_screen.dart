import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/routes_manager.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double responsiveFontSize(BuildContext context, double baseFontSize) {
      return screenWidth * (baseFontSize / 375);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: AnimatedTextKit(
                totalRepeatCount: 1,
                animatedTexts: [
                  ScaleAnimatedText(
                    'مرحبا',
                    textStyle: GoogleFonts.alexandria(
                      color: Colors.black,
                      fontSize: responsiveFontSize(context, 65),
                      fontWeight: FontWeight.w600,
                    ),
                    duration: const Duration(seconds: 4),
                  ),
                ],
                onFinished: () {
                  Navigator.pushReplacementNamed(
                      context, RoutesManager.qrScanRoute);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}