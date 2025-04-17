// student_behavior_controller.dart
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'StudentBehaviorModel.dart';

class StudentBehaviorController extends GetxController {
  var studentBehaviors = <StudentBehavior>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchStudentBehaviors();
    super.onInit();
  }

  Future<Map<String, int?>> fetchIdsFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userData = prefs.getString('user_data');

    int? studentId;
    int? classroomId;

    if (userData != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userType = prefs.getString('user_type');
      if(userType=="parent") {
        print("parent app");
        var userJson = json.decode(userData);
        studentId = userJson['user']['student_id'] as int?;
        classroomId = userJson['user']['classroom_id'] as int?;
        print("id :$studentId ,class is : $classroomId");
      }else {
        var userJson = json.decode(userData);
        studentId = userJson['user']['id'] as int?;
        classroomId = userJson['user']['classroom_id'] as int?;
        print("id :$studentId ,class is : $classroomId");
      }
    }


    return {'student_id': studentId, 'classroom_id': classroomId};
  }

  void fetchStudentBehaviors() async {
    isLoading(true);
    try {
      var ids = await fetchIdsFromPrefs();
      int? studentId = ids['student_id'];
      int? classroomId = ids['classroom_id'];

      if (studentId == null || classroomId == null) {
        print("Student ID or Classroom ID not found in SharedPreferences.");
        return;
      }

      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      };
      var request = http.Request(
        'GET',
        Uri.parse('http://127.0.0.1:8000/api/auth/parent/parent_getStudentNotes1?student_id=$studentId'), // استخدم عنوان IP الصحيح
      );
      request.headers.addAll(headers);

      print('Sending request...');
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print('Response status is 200');
        String responseBody = await response.stream.bytesToString();
        print('Response body: $responseBody');  // طباعة الرد للتحقق من البيانات
        var jsonResponse = json.decode(responseBody);
        print('JSON Response: $jsonResponse');  // طباعة الرد للتحقق من البيانات
        var notesList = jsonResponse as List;
        print('Notes List: $notesList');  // طباعة الرد للتحقق من البيانات
        studentBehaviors.value = notesList.map((note) => StudentBehavior.fromJson(note)).toList();
        print('Student Behaviors: ${studentBehaviors.value}');  // طباعة الرد للتحقق من البيانات
      } else {
        print('Failed to load student behaviors, status code: ${response.statusCode}');
        // Get.snackbar('Error', 'Failed to load student behaviors');
      }
    } catch (e) {
      print('Error: $e');
      // Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }
}
