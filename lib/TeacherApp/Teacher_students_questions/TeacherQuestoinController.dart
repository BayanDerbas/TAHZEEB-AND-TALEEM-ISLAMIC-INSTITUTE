import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:sprint1/TeacherApp/Teacher_students_questions/TeacherQuestoinModel.dart';





class TeacherQuestionController extends GetxController {
  var answeredQuestions = <StudentQuestion>[].obs;
  var unansweredQuestions = <StudentQuestion>[].obs;

  @override
  void onInit() {
    fetchStudentQuestionsToken();
    fetchQuestions();
    super.onInit();
  }

  String? accessToken;

  Future<void> fetchStudentQuestionsToken() async {
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
  }

  Future<void> fetchQuestions() async {
    await fetchStudentQuestionsToken();
    print("Access Token: $accessToken");

    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    var request = http.Request('GET', Uri.parse('http://127.0.0.1:8000/api/auth/teacher/teacher_showStudentQuestions'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    print("Response Status Code: ${response.statusCode}");
    if (response.statusCode == 200) {
      var responseData = json.decode(await response.stream.bytesToString());

      // Clear current lists
      answeredQuestions.clear();
      unansweredQuestions.clear();

      // Update lists based on the response data
      for (var questionJson in responseData) {
        var question = StudentQuestion.fromJson(questionJson);
        if (question.question == "1") {
          answeredQuestions.add(question);
        } else if (question.question == "0") {
          unansweredQuestions.add(question);
        }
      }
    } else {
      print(response.reasonPhrase);
    }
  }


// Future<void> fetchQuestions() async {
//   await fetchStudentQuestionsToken();
//   print("AAAAAAAAAAAAAAAAAccess Token: $accessToken");
//
//   var headers = {
//     'Accept': 'application/json',
//     'Content-Type': 'application/json',
//     'Authorization': 'Bearer $accessToken',
//   };
//
//   var request = http.Request('GET', Uri.parse('http://127.0.0.1:8000/api/auth/adviser/adviser_showStudentConsult'));
//   request.headers.addAll(headers);
//
//   http.StreamedResponse response = await request.send();
//
//   print("sssssssssssssssss${response.statusCode}");
//   if (response.statusCode == 200) {
//     var responseData = json.decode(await response.stream.bytesToString());
//
//     // Assuming the response is a list of questions
//     for (var questionJson in responseData) {
//       var question = StudentQuestion.fromJson(questionJson);
//       if (question.answered == "1") {
//         answeredQuestions.add(question);
//       } else if (question.answered == "0") {
//         unansweredQuestions.add(question);
//       }
//     }
//   } else {
//     print(response.reasonPhrase);
//   }
// }
}

