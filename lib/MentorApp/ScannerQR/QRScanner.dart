// import 'package:flutter/material.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
//
// class BarcodeScanPage extends StatefulWidget {
//   const BarcodeScanPage({super.key});
//
//   @override
//   _BarcodeScanPageState createState() => _BarcodeScanPageState();
// }
//
// class _BarcodeScanPageState extends State<BarcodeScanPage> {
//   String _barcode = "Scan a barcode";
//
//   Future<void> _scanBarcode() async {
//     try {
//       final scannedBarcode = await FlutterBarcodeScanner.scanBarcode(
//         '#ff6666', // لون النص
//         'Cancel', // نص زر الإلغاء
//         true, // عرض Flash
//         ScanMode.BARCODE, // وضع المسح (يمكنك تغيير إلى QR_CODE إذا كنت تريد مسح رموز QR)
//       );
//       if (scannedBarcode != '-1') {
//         setState(() {
//           _barcode = scannedBarcode;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _barcode = "Failed to get barcode.";
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Barcode Scanner'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             ElevatedButton(
//               onPressed: _scanBarcode,
//               child: const Text('Scan Barcode'),
//             ),
//             const SizedBox(height: 20),
//             Text(
//               'Barcode: $_barcode',
//               style: const TextStyle(fontSize: 18),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';

import 'ScannerQR_controller.dart';

class BarcodeScanPage extends StatelessWidget {
  final TeacherAttendanceController teacherAttendanceController =
  Get.put(TeacherAttendanceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Barcode Scanner'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Obx(() {
              if (teacherAttendanceController.isLoading.value) {
                return const CircularProgressIndicator();
              }
              return ElevatedButton(
                onPressed: () => _scanBarcode(),
                child: const Text('Scan Barcode'),
              );
            }),
            const SizedBox(height: 20),
            Obx(() {
              return Text(
                teacherAttendanceController.attendanceMessage.value,
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              );
            }),
          ],
        ),
      ),
    );
  }

  Future<void> _scanBarcode() async {
    try {
      final scannedBarcode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', // لون النص
        'Cancel', // نص زر الإلغاء
        true, // عرض Flash
        ScanMode.BARCODE, // وضع المسح (يمكنك تغيير إلى QR_CODE إذا كنت تريد مسح رموز QR)
      );

      if (scannedBarcode != '-1') {
        teacherAttendanceController.markAttendance(scannedBarcode);
      }
    } catch (e) {
      teacherAttendanceController.attendanceMessage.value = "Failed to get barcode.";
    }
  }
}
