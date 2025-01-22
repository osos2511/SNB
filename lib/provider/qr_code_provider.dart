import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class QrCodeProvider extends ChangeNotifier {
  bool isLoading = false;
  String? message;
  bool isScanned = false;

  Future<void> setBarcode(String? code, BuildContext context) async {
    if (isScanned) return;
    isScanned = true;
    isLoading = true;
    notifyListeners();

    const String apiUrl = 'https://ksaexpo.online/api/qrcode/check';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'qrcode': code}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['status'] != null && data['status'] == true) {
          message = data['message'] ?? 'الحساب مسجل';
          await showCustomDialog(context, "عملية ناجحة");
        } else {
          message = data['message'] ?? 'الحساب غير مسجل';
          await showCustomDialog(context, "خطأ");
        }
      } else {
        message = 'خطأ أثناء فحص الباركود , خطأ في الخادم';
        await showCustomDialog(context, "خطأ");
      }
    } catch (e) {
      message = 'Error: $e';
      await showCustomDialog(context, "خطأ");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> showCustomDialog(BuildContext context, String title) async {
    if (Navigator.canPop(context)) return;

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title,textAlign: TextAlign.center,),
          actions: [
            TextButton(
              onPressed: () {
                resetScan();
                Navigator.of(context).pop();
              },
              child:  Text("تم"),
            ),
          ],
        );
      },
    );
    isScanned = false;
  }

  void resetScan() {
    isLoading = false;
    isScanned = false;
    message = null;
    notifyListeners();
  }
}