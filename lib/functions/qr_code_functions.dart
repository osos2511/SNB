import 'package:gallary_system/provider/qr_code_provider.dart';
import 'package:get/get.dart';
class QrCodeFunctions{
  static Future<void> scanBarcode() async {
    String? barcode = await Get.to(() => QrCodeProvider());

    if (barcode != null && barcode.isNotEmpty) {
      Get.snackbar(
        "Barcode Scanned",
        "Scanned Barcode: $barcode",
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {

      Get.snackbar(
        "Scan Cancelled",
        "No barcode was scanned.",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}