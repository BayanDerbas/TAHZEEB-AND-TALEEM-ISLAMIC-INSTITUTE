// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// import 'ClassModel.dart';
// import 'SubjectModel.dart';
//
// class HomeworkController extends GetxController {
//   var classrooms = <Classroom>[].obs;
//   var subjects = <Subject>[].obs;
//   var selectedClassroomId = 0.obs;
//   var selectedSubjectId = 0.obs; // إضافة هذا المتغير
//
//   @override
//   void onInit() {
//     fetchClassrooms();
//     super.onInit();
//   }
//
//   void fetchClassrooms() async {
//     var headers = {
//       'Accept': 'application/json',
//       'Content-Type': 'application/json',
//     };
//     var request = http.Request('GET', Uri.parse('http://127.0.0.1:8000/api/auth/teacher/teacher_getClasses'));
//     request.headers.addAll(headers);
//
//     http.StreamedResponse response = await request.send();
//
//     if (response.statusCode == 200) {
//       var jsonData = json.decode(await response.stream.bytesToString()) as List;
//       classrooms.assignAll(jsonData.map((item) => Classroom.fromJson(item)).toList());
//     } else {
//       print(response.reasonPhrase);
//     }
//   }
//
//   void fetchSubjects(int classroomId) async {
//     var headers = {
//       'Accept': 'application/json',
//       'Content-Type': 'application/json',
//     };
//     var request = http.Request('POST', Uri.parse('http://127.0.0.1:8000/api/auth/teacher/teacher_getSubjectsByClassroom?classroom_id=$classroomId'));
//     request.headers.addAll(headers);
//
//     http.StreamedResponse response = await request.send();
//
//     if (response.statusCode == 200) {
//       var jsonData = json.decode(await response.stream.bytesToString()) as List;
//       subjects.assignAll(jsonData.map((item) => Subject.fromJson(item)).toList());
//       if (subjects.isNotEmpty) {
//         selectedSubjectId.value = subjects[0].id; // تعيين القيمة الافتراضية لأول مادة في القائمة
//       }
//     } else {
//       print(response.reasonPhrase);
//     }
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'ClassModel.dart';
import 'SubjectModel.dart';

class HomeworkController extends GetxController {
  var classrooms = <Classroom>[].obs;
  var subjects = <Subject>[].obs;
  var selectedClassroomId = 0.obs;
  var selectedSubjectId = 0.obs;
  var typeValue = ''.obs;
  var notes = ''.obs;
  var homeworkName = ''.obs;
  var selectedDate = ''.obs;
  var teacherId = 1; // ضع معرف المدرس هنا

  @override
  void onInit() {
    loadUserData(); // Load user data and token
    fetchClassrooms();
    super.onInit();
  }

  Future<String?> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userData = prefs.getString('user_data');
    String? accessToken;

    if (userData != null) {
      var userJson = json.decode(userData);
      accessToken = userJson['access_token'] as String?;
      print("Access Token: $accessToken");
    }
    return accessToken;
  }


  void fetchClassrooms() async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    var request = http.Request('GET', Uri.parse('http://127.0.0.1:8000/api/auth/teacher/teacher_getClasses'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsonData = json.decode(await response.stream.bytesToString()) as List;
      classrooms.assignAll(jsonData.map((item) => Classroom.fromJson(item)).toList());
    } else {
      print(response.reasonPhrase);
    }
  }

  void fetchSubjects(int classroomId) async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    var request = http.Request('POST', Uri.parse('http://127.0.0.1:8000/api/auth/teacher/teacher_getSubjectsByClassroom?classroom_id=$classroomId'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsonData = json.decode(await response.stream.bytesToString()) as List;
      subjects.assignAll(jsonData.map((item) => Subject.fromJson(item)).toList());
      if (subjects.isNotEmpty) {
        selectedSubjectId.value = subjects[0].id; // تعيين القيمة الافتراضية لأول مادة في القائمة
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  void sendHomework() async {
    String? token = await loadUserData(); // Fetch the token

    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var request = http.MultipartRequest(
        'POST', Uri.parse('http://127.0.0.1:8000/api/auth/teacher/teacher_sendHomeworkOrLesson')
    );

    request.fields.addAll({
      'classroom_id': selectedClassroomId.value.toString(),
      'teacher_id': teacherId.toString(),
      'subject_id': selectedSubjectId.value.toString(),
      'type': typeValue.value,
      'notes': notes.value,
      'date': selectedDate.value,
      'homework_name': homeworkName.value,
    });

    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      var responseBody = await response.stream.bytesToString();

      print('Status Code: ${response.statusCode}');
      print('Response Body: $responseBody');

      if (response.statusCode == 200 ||response.statusCode==201) { // or 201, depending on your API
        Get.snackbar(
          "Success",  // Title
          "تم الرفع بنجاح",  // Message
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // Clear the fields
        selectedClassroomId.value = 0;
        selectedSubjectId.value = 0;
        typeValue.value = '';
        notes.value = '';
        homeworkName.value = '';
        selectedDate.value = '';
      } else {
        Get.snackbar(
          "Error",  // Title
          "خطأ في الرفع: ${response.reasonPhrase}",  // Message
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Exception",  // Title
        "Exception: $e",  // Message
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
