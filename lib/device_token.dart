// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
//
// class DeviceToken extends StatefulWidget {
//   @override
//   _DeviceTokenState createState() => _DeviceTokenState();
// }
//
// class _DeviceTokenState extends State<DeviceToken> {
//   String? deviceToken;
//
//   @override
//   void initState() {
//     super.initState();
//     getToken();
//   }
//
//   void getToken() async {
//     String? token = await FirebaseMessaging.instance.getToken();
//     setState(() {
//       deviceToken = token;
//     });
//     print("Device Token: $token");
//
//     // هنا يمكنك إرسال التوكن إلى السيرفر الخاص بك
//     sendTokenToServer(token);
//   }
//
//   void sendTokenToServer(String? token) {
//     // أرسل التوكن إلى السيرفر الخاص بك عبر HTTP أو أي طريقة أخرى
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('FCM Demo'),
//       ),
//       body: Center(
//         child: Text('Device Token: $deviceToken'),
//       ),
//     );
//   }
// }
