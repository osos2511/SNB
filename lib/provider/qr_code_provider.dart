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

    const String checkApiUrl = 'https://ksaexpo.online/api/qrcode/check';
    const String visitApiUrl = 'https://ksaexpo.online/api/qrcode/visit';

    try {
      final response = await http.post(
        Uri.parse(checkApiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'qrcode': code}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['status'] != null && data['status'] == true) {
          message = data['message'] ?? 'الحساب مسجل';

          await sendVisitLog(code, visitApiUrl, context);

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

  Future<void> sendVisitLog(String? code, String apiUrl, BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'qrcode': code}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['status'] != null && data['status'] == true) {
          print("تم تسجيل الزيارة بنجاح.");
        } else {
          print("فشل تسجيل الزيارة: ${data['message'] ?? 'خطأ غير معروف'}");
        }
      } else {
        print("خطأ أثناء تسجيل الزيارة , خطأ في الخادم");
      }
    } catch (e) {
      print("Error أثناء تسجيل الزيارة: $e");
    }
  }

  Future<void> showCustomDialog(BuildContext context, String title) async {
    if (Navigator.canPop(context)) return;

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () {
                resetScan();
                Navigator.of(context).pop();
              },
              child: Text("تم"),
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
