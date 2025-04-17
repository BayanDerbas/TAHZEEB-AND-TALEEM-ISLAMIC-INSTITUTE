import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../StudentApp/Student_question/StudentQuestoinModel.dart';
// import 'package:sprint1/AdviserApp/ConsultResponse/ConsultModel.dart';

class QuestionReplyController extends GetxController {
  var message = ''.obs;
  var textController = TextEditingController();
  var advisor = Rx<StudentQuestion?>(null); // Assuming you're using ConsultModel for advisor
  var isLoading = false.obs;


  @override
  void onInit() {
    fetchToken();
    super.onInit();
  }
  Future<Map<String, int?>> fetchIdsFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userData = prefs.getString('user_data');

    int? teacherId;

    if (userData != null) {

        var userJson = json.decode(userData);
        teacherId = userJson['user']['id'] as int?;
        print("id :$teacherId ");

    }

    return {'student_id': teacherId};
  }


  Future<void> sendMessage(int QuestionId, String replyText) async {
    String? accessToken;

    try {
      var ids = await fetchIdsFromPrefs();
      int? teacherId = ids['student_id'];

      if (teacherId == null) {
        print("Student ID or Classroom ID not found in SharedPreferences.");
        return;
      }
      // Fetch access token from SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userData = prefs.getString('user_data');
      if (userData != null) {
        Map<String, dynamic> userMap = jsonDecode(userData);
        accessToken = userMap['access_token'];
      } else {
        throw Exception("User data not found");
      }

      // Set headers for the request
      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      };

      // Send the reply to the server
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/api/auth/teacher/teacher_replyToQuestion?reply=$replyText&question_id=$QuestionId&teacher_id=$teacherId'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        textController.clear();
        message.value = ''; // Clear the message field on success
        Get.snackbar("Success", "Message sent successfully");
        // Notify that the data needs to be refreshed
        Get.back(result: true);
        print(response.body);
      } else {
        print('Failed with status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to send reply');
      }
    } catch (e) {
      print("Error sending reply: $e");
      Get.snackbar("Error", "Failed to send message");
    }
  }

  Future<void> fetchReplyByQuestionId(int consultId) async {
    print("bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb");
    isLoading(true);
    try {
      var request = http.Request('GET', Uri.parse('http://127.0.0.1:8000/api/auth/teacher/teacher_showQuestionReplies'));

      http.StreamedResponse response = await request.send();

      print("bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb${response.statusCode}");
      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        // Parse the JSON response and find the reply for the specific consultId
        var replies = jsonDecode(responseData) as List;
        var reply = replies.firstWhere((reply) => reply['question_id'] == consultId, orElse: () => null);

        if (reply != null) {
          message.value = reply['reply'];
        } else {
          message.value = 'لم يتم العثور على رد للاستشارة.';
        }
      } else {
        message.value = 'حدث خطأ أثناء جلب الرد.';
      }
    } catch (e) {
      message.value = 'حدث خطأ: $e';
    } finally {
      isLoading(false);
    }
  }


  Future<void> fetchToken() async {
    String? accessToken;

    try {
      // Fetch access token from SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userData = prefs.getString('user_data');
      if (userData != null) {
        Map<String, dynamic> userMap = jsonDecode(userData);
        accessToken = userMap['access_token'];
        print("Access Token: $accessToken");
      } else {
        throw Exception("User data not found");
      }
    } catch (e) {
      print("Exception fetching consult : $e");
    }
  }
}


