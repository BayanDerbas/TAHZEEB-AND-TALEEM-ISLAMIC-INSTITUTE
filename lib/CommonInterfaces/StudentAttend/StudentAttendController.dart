// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'StudentAttendModel.dart';
//
// class StudentAttendanceController extends GetxController {
//   var isLoading = true.obs;
//   var attendance = <Attendance>[].obs;
//   var summary = Summary(present: 0, late: 0, absent: Absent(justified: 0, unjustified: 0)).obs;
//
//   @override
//   void onInit() {
//     fetchAttendance();
//     super.onInit();
//   }
//
//   void fetchAttendance() async {
//     try {
//       var request = http.Request(
//         'GET',
//         Uri.parse('http://127.0.0.1:8000/api/auth/parent/parent_showStudentAttendance?student_id=1&classroom_id=1'),
//       );
//
//       http.StreamedResponse response = await request.send();
//
//       if (response.statusCode == 200) {
//         var responseData = await response.stream.bytesToString();
//         var jsonData = json.decode(responseData);
//         print('Raw response data: $responseData'); // Print the raw response
//
//         attendance.value = (jsonData['attendance'] as List)
//             .map((i) => Attendance.fromJson(i))
//             .toList();
//
//         summary.value = Summary.fromJson(jsonData['summary']);
//       } else {
//         print(response.reasonPhrase);
//       }
//     } catch (e) {
//       print("Error fetching data: $e");
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'StudentAttendModel.dart';

class StudentAttendanceController extends GetxController {
  var isLoading = true.obs;
  var attendance = <Attendance>[].obs;
  var summary = Summary(present: 0, late: 0, absent: Absent(justified: 0, unjustified: 0)).obs;

  @override
  void onInit() {
    fetchAttendance();
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

  void fetchAttendance() async {
    try {
      var ids = await fetchIdsFromPrefs();
      int? studentId = ids['student_id'];
      int? classroomId = ids['classroom_id'];

      if (studentId == null || classroomId == null) {
        print("Student ID or Classroom ID not found in SharedPreferences.");
        return;
      }

      var request = http.Request(
        'GET',
        Uri.parse('http://127.0.0.1:8000/api/auth/parent/parent_showStudentAttendance?student_id=$studentId&classroom_id=$classroomId'),
      );

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        var jsonData = json.decode(responseData);
        print('Raw response data: $responseData'); // Print the raw response

        attendance.value = (jsonData['attendance'] as List)
            .map((i) => Attendance.fromJson(i))
            .toList();

        summary.value = Summary.fromJson(jsonData['summary']);
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print("Error fetching data: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
