// // controllers/homework_controller.dart
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// import 'HomeworksModel.dart';
//
// class HomeworkController extends GetxController {
//   var homeworks = <Homework>[].obs;
//   var isLoading = true.obs;
//
//   @override
//   void onInit() {
//     fetchHomeworks();
//     super.onInit();
//   }
//
//   void fetchHomeworks() async {
//     try {
//       isLoading(true);
//       var headers = {
//         'Accept': 'application/json',
//         'Content-Type': 'application/json'
//       };
//       var request = http.Request(
//           'POST',
//           Uri.parse(
//               'http://127.0.0.1:8000/api/auth/student/student_showHomework?classroom_id=1'));
//       request.headers.addAll(headers);
//
//       http.StreamedResponse response = await request.send();
//
//       if (response.statusCode == 200) {
//         var data = await response.stream.bytesToString();
//         var jsonResult = json.decode(data) as List;
//         homeworks.value =
//             jsonResult.map((json) => Homework.fromJson(json)).toList();
//       } else {
//         print(response.reasonPhrase);
//       }
//     } finally {
//       isLoading(false);
//     }
//   }
// }
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'HomeworksModel.dart';

class HomeworkController extends GetxController {
  var homeworks = <Homework>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchHomeworks();
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

  void fetchHomeworks() async {
    try {
      isLoading(true);

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
          'POST',
          Uri.parse(
              'http://127.0.0.1:8000/api/auth/student/student_showHomework?classroom_id=$classroomId'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var data = await response.stream.bytesToString();
        var jsonResult = json.decode(data) as List;
        homeworks.value =
            jsonResult.map((json) => Homework.fromJson(json)).toList();
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print("Error fetching data: $e");
    } finally {
      isLoading(false);
    }
  }
}
