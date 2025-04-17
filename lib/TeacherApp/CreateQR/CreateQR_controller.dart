import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QRCodeController extends GetxController {
  var userId = ''.obs; // المتغير المستخدم لحفظ قيمة الـ ID

  @override
  void onInit() {
    super.onInit();
    _loadUserData(); // تحميل البيانات عند التهيئة
  }

  Future<void> _loadUserData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userData = prefs.getString('user_data');
      if (userData != null) {
        Map<String, dynamic> userMap = jsonDecode(userData);
        userId.value = userMap['user']['id'].toString(); // حفظ ID المستخدم
      } else {
        throw Exception("User data not found");
      }
    } catch (e) {
      print("Exception fetching user data: $e");
    }
  }
}
