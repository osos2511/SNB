import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../core/routes_manager.dart';

class QrCodeProvider extends ChangeNotifier {
  bool isLoading = false;
  String? message;
  bool isScanned = false;

  Future<void> setBarcode(String? code, BuildContext context) async {
    const String apiUrl = 'https://ksaexpo.online/api/qrcode/check';
    isLoading = true;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'qrcode': code}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['status'] != null && data['status'] == true) {
          isScanned = true;
          message = data['message'] ?? 'QR Code verified successfully.';
          Navigator.pushReplacementNamed(context, RoutesManager.successRoute);
        } else {
          isScanned = false;
          message = data['message'] ?? 'Invalid QR Code.';
          Navigator.pushReplacementNamed(context, RoutesManager.errorRoute);
          print(message);
        }
      } else {
        message = 'Failed to check QR Code. Server error.';
        isScanned = false;
        Navigator.pushReplacementNamed(context, RoutesManager.errorRoute);
      }
    } catch (e) {
      message = 'Error: $e';
      isScanned = false;
      Navigator.pushReplacementNamed(context, RoutesManager.errorRoute);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void resetScan() {
    isLoading = false;
    isScanned = false;
    message = null;
    notifyListeners();
  }
}
