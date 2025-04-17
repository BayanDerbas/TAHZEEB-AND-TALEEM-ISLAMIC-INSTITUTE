import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'GuardModel.dart'; // Make sure the path is correct

class GuardController extends GetxController {
  var isLoading = false.obs;
  var guards = <GuardModel>[].obs;

  Future<void> fetchGuards(String userType) async {
    isLoading(true);
    try {
      String apiUrl = 'http://127.0.0.1:8000/api/auth/student/student_showGuards';

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('accessToken');

      var response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token', // التأكد من تمرير التوكن
        },
      );

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body) as List;
        guards.value = jsonData.map((data) => GuardModel.fromJson(data)).toList();
      } else {
        print('Failed to load guards: ${response.statusCode}');
        print('Response: ${response.body}'); // طباعة الخرج لتتبع المشكلة
      }
    } catch (e) {
      print('An error occurred: $e');
    } finally {
      isLoading(false);
    }
  }
}
