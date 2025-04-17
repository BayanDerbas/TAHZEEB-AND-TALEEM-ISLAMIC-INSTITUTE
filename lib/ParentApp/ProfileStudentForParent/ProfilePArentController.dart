// // student_controller.dart
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:sprint1/ProfileStudent/ProfileStudentModel.dart'; // for json.decode
//
// class StudentController extends GetxController {
//   var student = ProfileModel(
//     id: 0,
//     classroomId: 0,
//     departmentId: 0,
//     adviserId: 0,
//     name: '',
//     email: '',
//     password: '',
//     phone: '',
//     dataBirth: '',
//   ).obs;
//
//   @override
//   void onInit() {
//     fetchStudentProfile();
//     super.onInit();
//   }
//   var accessToken;
//   Future<void> fetchStudentProfile() async {
//     // استخراج التوكين من SharedPreferences
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? userData = prefs.getString('user_data');
//     if (userData != null) {
//       // تحويل سلسلة JSON إلى خريطة
//       Map<String, dynamic> userMap = jsonDecode(userData);
//       accessToken = userMap['access_token'];
//       print('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%$accessToken');
//     }
//
//     // إعداد الترويسة مع التوكين
//     var headers = {
//       'Accept': 'application/json',
//       'Content-Type': 'application/json',
//       'Authorization': 'Bearer $accessToken',
//     };
//
//     var request = http.Request('GET', Uri.parse('http://127.0.0.1:8000/api/auth/student/student_profile'));
//     request.headers.addAll(headers);
//
//     try {
//       http.StreamedResponse response = await request.send();
//       if (response.statusCode == 200) {
//         String responseBody = await response.stream.bytesToString();
//         var json = jsonDecode(responseBody);
//         student.value = ProfileModel.fromJson(json);
//         print(".................................................................");
//         print(response.statusCode);
//       } else {
//         // Handle error response
//         print(response.statusCode);
//         print("Error gggggggggggggggggggggggggggggggggggggggggggggggg${response.statusCode} ");
//       }
//     } catch (e) {
//       print("Exception wwwwwwwwwwwwwwwwwwwwwwwwwwwwwww$e");
//     }
//   }
// }
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sprint1/StudentApp/ProfileStudent/ProfileStudentModel.dart';
import 'package:sprint1/StudentApp/ProfileStudent/range.dart'; // for json.decode

class ProfileParentController extends GetxController {
  var student = ProfileModel(
    id: 0,
    classroomId: 0,
    departmentId: 0,
    name: '',
    email: '',
    password: '',
    phone: '',
    dataBirth: '',
    classroomName: '',
    educationStage: '',
  ).obs;

  var Range=StudentDegreesModel(
      subjects: [],
      finalAverageMark: 0

  ).obs;

  var studentRank = 0.obs; // متغير لمراقبة رتبة الطالب
  var range = 0.obs; // متغير لمراقبة رتبة الطالب
// متغير لمراقبة نقاط الطالب
  var studentScore = 0.obs;

  @override
  void onInit() {
    fetchStudentProfile();
    fetchStudentRank();
    fetchStudentDegrees();
    fetchStudentScore(); // استدعاء الدالة الجديدة لجلب النقاط
    super.onInit();
  }

  // الدالة الجديدة لجلب نقاط الطالب
  Future<void> fetchStudentScore() async {
    var ids = await fetchIdsFromPrefs();
    int? studentId = ids['student_id'];

    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    var request = http.Request('GET', Uri.parse('http://127.0.0.1:8000/api/auth/student/student_getStudentRate?student_id=$studentId'));
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        var json = jsonDecode(responseBody);
        studentScore.value = json['total_score'] != null ? int.parse(json['total_score']) : 0;
        print("Student Score: ${studentScore.value}");
      } else {
        print("Error fetching student score: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception fetching student score: $e");
    }
  }

  Future<Map<String, int?>> fetchIdsFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userData = prefs.getString('user_data');

    int? studentId;
    int? classroomId;

    if (userData != null) {
      var userJson = json.decode(userData);
      studentId = userJson['user']['student_id'] as int?;
      classroomId=userJson['user']['classroom_id'] as int?;
      print("id :$studentId ,class is : $classroomId");
    }


    return {'student_id': studentId, 'classroom_id': classroomId};
  }

  var accessToken;

  Future<void> fetchStudentProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userData = prefs.getString('user_data');
    if (userData != null) {
      Map<String, dynamic> userMap = jsonDecode(userData);
      accessToken = userMap['access_token'];
      print('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%$accessToken');
    }

    var ids = await fetchIdsFromPrefs();
    int? studentId = ids['student_id'];

    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    var request = http.Request('GET', Uri.parse('http://127.0.0.1:8000/api/auth/parent/parent_showStudentProfile?student_id=$studentId'));
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();
      print("sssssssssssssssssssssssssssssssssssss${response.statusCode}");

      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        var json = jsonDecode(responseBody);
        print("Student Profile JSON Response: $json");

        student.value = ProfileModel.fromJson(json);

        print("Student Profile fetched successfully.");
      } else {
        print(response.statusCode);
        print("Error fetching student profile: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception fetching student profile: $e");
    }
  }

  Future<void> fetchStudentRank() async {
    var ids = await fetchIdsFromPrefs();
    int? studentId = ids['student_id'];
    int? classroomId = ids['classroom_id'];

    // إعداد الترويسة مع التوكين
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    var request = http.Request('GET', Uri.parse('http://127.0.0.1:8000/api/auth/student/student_getStudentRank?student_id=$studentId'));
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        var json = jsonDecode(responseBody);
        studentRank.value = json['student_rank']; // تحديث قيمة الرانك
        print("Student Rank: ${studentRank.value}");
      } else {
        print("Error fetching rank: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception fetching rank: $e");
    }
  }

  Future<void> fetchStudentDegrees() async {
    var ids = await fetchIdsFromPrefs();
    int? studentId = ids['student_id'];
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    var request = http.Request('GET', Uri.parse('http://127.0.0.1:8000/api/auth/student/student_showDegrees?student_id=$studentId'));
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        print(responseBody);
        var json = jsonDecode(responseBody);
        StudentDegreesModel studentDegrees = StudentDegreesModel.fromJson(json);

        // Update the Range observable with the new finalAverageMark
        Range.update((val) {
          if (val != null) {
            val.finalAverageMark = studentDegrees.finalAverageMark;
          }
        });

        // You might also want to update other parts of Range if necessary
        // For example, if `Range` holds other student degree data:
        // Range.update((val) {
        //   if (val != null) {
        //     val.subjects = studentDegrees.subjects;
        //     val.finalAverageMark = studentDegrees.finalAverageMark;
        //   }
        // });

        print("Final Average Mark updated to: ${studentDegrees.finalAverageMark}");
      } else {
        print("Error fetching student degrees: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception fetching student degrees: $e");
    }
  }
}
