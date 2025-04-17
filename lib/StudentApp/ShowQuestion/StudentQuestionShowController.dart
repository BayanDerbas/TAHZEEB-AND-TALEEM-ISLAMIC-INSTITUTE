import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'StudentQuestionModel.dart';
import 'StudentQuestionReplyModel.dart';


//
// class StudentQuestionShowController extends GetxController {
//   var consultations = <QuestionModel>[].obs;
//   var message = ''.obs;
//   var textController = TextEditingController();
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchConsultToken();
//   }
//   String? accessToken;
//
//   Future<void> fetchConsultToken() async {
//
//     try {
//       // Fetch access token from SharedPreferences
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       String? userData = prefs.getString('user_data');
//       if (userData != null) {
//         Map<String, dynamic> userMap = jsonDecode(userData);
//         accessToken = userMap['access_token'];
//         print("Access Token: $accessToken");
//       } else {
//         throw Exception("User data not found");
//       }
//     } catch (e) {
//       print("Exception fetching consult : $e");
//     }
//   }
//
//
//   void fetchConsultationById(int QuestionId) async {
//     await fetchConsultToken();  // Ensure token is fetched before making the request
//
//     if (accessToken == null) {
//       print("Access Token is null.");
//       return;
//     }
//
//     var headers = {
//       'Accept': 'application/json',
//       'Content-Type': 'application/json',
//       'Authorization': 'Bearer $accessToken',
//     };
//
//     var response = await http.get(
//       Uri.parse('http://127.0.0.1:8000/api/auth/student/student_getQuestionById?id=$QuestionId'),
//       headers: headers,
//     );
//
//     print("Status Code: ${response.statusCode}");
//     print("Response Body: ${response.body}");
//
//     if (response.statusCode == 200) {
//       // هنا نتعامل مع كائن JSON وليس قائمة
//       var jsonResponse = json.decode(response.body) as Map<String, dynamic>;
//
//       var consultation = QuestionModel.fromJson(jsonResponse);
//       consultations.value = [consultation];  // نقوم بتحديث القائمة بإضافة الاستشارة المفردة
//
//       print("Consultation loaded successfully.");
//     } else {
//       // معالجة الخطأ
//       print('Failed to load consultation');
//     }
//   }
//
//   void sendMessage(int adviserId, int consultId) {
//     if (textController.text.trim().isNotEmpty) {
//       message.value = textController.text.trim();
//       // Here you would send the message to the server.
//     }
//   }
//
//
//
//
// }
class StudentQuestionShowController extends GetxController {
  var consultations = <QuestionModel>[].obs;
  var replies = <ReplyModel>[].obs; // لإضافة المتغير الخاص بالردود
  var message = ''.obs;
  var textController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchConsultToken();
  }

  String? accessToken;

  Future<void> fetchConsultToken() async {
    try {
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

  void fetchConsultationById(int questionId) async {
    await fetchConsultToken();  // Ensure token is fetched before making the request

    if (accessToken == null) {
      print("Access Token is null.");
      return;
    }

    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    var response = await http.get(
      Uri.parse('http://127.0.0.1:8000/api/auth/student/student_getQuestionById?id=$questionId'),
      headers: headers,
    );

    print("Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body) as List;
      if (jsonResponse.isNotEmpty) {
        var consultation = QuestionModel.fromJson(jsonResponse.first);
        consultations.value = [consultation];
        print("Consultation loaded successfully.");
      } else {
        print('No consultation data found');
      }
    } else {
      print('Failed to load consultation');
    }
  }


  Future<void> StudentfetchReplyByQuestionId(int consultId) async {
    print("bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb");
    try {
      var request = http.Request('GET', Uri.parse('http://127.0.0.1:8000/api/auth/student/student_showQuestionReplies'));

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
    }
  }

}


