import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sprint1/MentorApp/monitor_home/monitor_check_students/monitor_check_students_service.dart';
import 'package:sprint1/MentorApp/monitor_home/monitor_check_students/students_model.dart';

class MonitorCheckStudentsController extends GetxController {
  var classroomId = 0;
  var token = "";
  var isLoading = true.obs;
  var students = StudentsModel().obs;
  var studentsCheck = <bool>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadUserData();
  }
  String? accessToken;

  Future<void> _loadUserData() async {
    try {
      // Fetch access token from SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userData = prefs.getString('user_data');
      if (userData != null) {
        Map<String, dynamic> userMap = jsonDecode(userData);
        accessToken = userMap['access_token'];
      } else {
        throw Exception("User data not found");
      }
    } catch (e) {
      print("Exception fetching consult : $e");
    }
    // else {
    //   print("لم يتم العثور على بيانات المستخدم.");
    //   token =
    //       "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTI3LjAuMC4xOjgwMDAvYXBpL2F1dGgvbW9uaXRvci9sb2dpbiIsImlhdCI6MTcyMzczNzc3NCwiZXhwIjoxNzIzNzQxMzc0LCJuYmYiOjE3MjM3Mzc3NzQsImp0aSI6ImZoVlVSMkY5MzVBYlAzN2siLCJzdWIiOiIyIiwicHJ2IjoiMWU1OTI0NWI3ZDkwNjE0YzcyOTRjYzUxODNlZDIwMjIzMTI5NDk4OCJ9.bXaemNO7uxmdsCUT6lO54zV9lXYu5FRpnHfRfXEZ7Cg";
    // }
  }

  void fetchDegrees() async {
    try {
      isLoading(true);
      await _loadUserData();
      var studentDegrees =
          await MonitorCheckStudentsService().fetchStudents(classroomId, accessToken!);
      students.value = studentDegrees;

      studentDegrees.checkListAttendance!.forEach((element) {
        studentsCheck.add(false);
      });
    } finally {
      isLoading(false);
    }
  }

  Future<void> markAttendance() async {
    try {
      await _loadUserData();
      isLoading(true);
      for (var entry in students.value.checkListAttendance!.asMap().entries) {
        await MonitorCheckStudentsService().saveAttendance(
            classroomId: entry.value.classroomId!,
            departmentId: entry.value.departmentId!,
            studentId: entry.value.id!,
            attendanceStatus: studentsCheck[entry.key] ? "حاضر" : "تأخر",
            attendanceDate: DateTime.now(),
            token: accessToken!);
      }
    } finally {
      isLoading(false);
    }
  }
}
