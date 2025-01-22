import 'package:flutter/material.dart';
import '../screens/mobile_scanner/scan_qr_code.dart';
import '../splash/splash_screen.dart';


class RoutesManager {
  static const String splashRoute = '/';
  static const String qrScanRoute = '/scan';

  static Route<dynamic>? router(RouteSettings settings) {
    switch (settings.name) {
      case splashRoute:
        {
          return MaterialPageRoute(builder: (context) => const Splash());
        }
      case qrScanRoute:
        {
          return MaterialPageRoute(builder: (context) => const QrCodeScanner());
        }
    }
  }
}
