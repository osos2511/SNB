import 'package:flutter/material.dart';
import 'package:gallary_system/screens/result_screens/error_page.dart';
import 'package:gallary_system/screens/result_screens/success_page.dart';
import '../screens/mobile_scanner/scan_qr_code.dart';
import '../screens/welcome_scan.dart';
import '../splash/splash_screen.dart';


class RoutesManager {
  static const String splashRoute = '/';
  static const String welcomeScanRoute = '/welcomeScan';
  static const String qrScanRoute = '/scan';
  static const String successRoute = '/success';
  static const String errorRoute = '/error';

  static Route<dynamic>? router(RouteSettings settings) {
    switch (settings.name) {
      case splashRoute:
        {
          return MaterialPageRoute(builder: (context) => const Splash());
        } case welcomeScanRoute:
        {
          return MaterialPageRoute(builder: (context) =>  WelcomeScan());
        }
      case qrScanRoute:
        {
          return MaterialPageRoute(builder: (context) => const QrCodeScanner());
        }
      case successRoute:
        {
          return MaterialPageRoute(builder: (context) => const SuccessPage());
        }
      case errorRoute:
        {
          return MaterialPageRoute(builder: (context) => const ErrorPage());
        }
    }
  }
}
