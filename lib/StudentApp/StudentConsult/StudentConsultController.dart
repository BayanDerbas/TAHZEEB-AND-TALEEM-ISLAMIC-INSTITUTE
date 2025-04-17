import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../StudentApp/Student_question/StudentQuestoinModel.dart';
import 'StudentConsultModel.dart';




class StudentConsultController extends GetxController {
  var answeredQuestions = <ConsultModel>[].obs;
  var unansweredQuestions = <ConsultModel>[].obs;

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

    var request = http.Request('GET', Uri.parse(
        'http://127.0.0.1:8000/api/auth/student/student_showAllConsult'
    ));
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
        var question = ConsultModel.fromJson(questionJson);
        if (question.answered == "1") {
          answeredQuestions.add(question);
        } else if (question.answered == "0") {
          unansweredQuestions.add(question);
        }
      }
    } else {
      print(response.reasonPhrase);
    }
  }
  // دالة لإضافة الاستشارة الجديدة إلى قائمة الاستشارات التي لم يُرد عليها
  void addUnansweredQuestion(ConsultModel newConsult) {
    unansweredQuestions.add(newConsult);
  }

}
