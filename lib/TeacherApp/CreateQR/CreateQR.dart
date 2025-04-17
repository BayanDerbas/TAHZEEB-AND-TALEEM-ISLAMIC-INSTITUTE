//
// import 'package:flutter/material.dart';
// import 'package:qr_flutter/qr_flutter.dart';
//
// class QRCodePage extends StatefulWidget {
//   const QRCodePage({super.key});
//
//   @override
//   State<QRCodePage> createState() => _QRCodePageState();
// }
//
// class _QRCodePageState extends State<QRCodePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('QR Code Generator'),
//       ),
//       body: Center(
//         child: QrImageView(
//           data: "https://www.example.com",
//           version: QrVersions.auto,
//           size: 200.0,
//           gapless: false,
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'CreateQR_controller.dart'; // قم باستيراد الـ Controller هنا

class QRCodePage extends StatelessWidget {
  final QRCodeController qrCodeController = Get.put(QRCodeController());

  QRCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code Generator'),
      ),
      body: Center(
        child: Obx(() {
          if (qrCodeController.userId.isEmpty) {
            return const CircularProgressIndicator(); // عرض مؤشر التحميل أثناء تحميل البيانات
          }

          // توليد الباركود بناءً على الـ ID
          return QrImageView(
            data: "${qrCodeController.userId}",
            version: QrVersions.auto,
            size: 200.0,
            gapless: false,
          );
        }),
      ),
    );
  }
}
