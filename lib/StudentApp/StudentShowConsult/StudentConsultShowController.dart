import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'StudentConsultModel.dart';
import 'StudentConsultReplyModel.dart';



class StudentConsultShowController extends GetxController {
  var consultations = <ConsultModel>[].obs;
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
    await fetchConsultToken(); // Ensure token is fetched before making the request

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
      Uri.parse(
          'http://127.0.0.1:8000/api/auth/student/student_getConsultById?id=$questionId'),
      headers: headers,
    );

    print("Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body) as List;
      if (jsonResponse.isNotEmpty) {
        var consultation = ConsultModel.fromJson(jsonResponse.first);
        consultations.value = [consultation];
        print("Consultation loaded successfully.");
      } else {
        print('No consultation data found');
      }
    } else {
      print('Failed to load consultation');
    }
  }


  Future<void> StudentfetchReplyByConsultId(int consultId) async {
    print(
        "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb");
    try {
      var request = http.Request('GET', Uri.parse(
          'http://127.0.0.1:8000/api/auth/student/student_showConsultReplies'));

      http.StreamedResponse response = await request.send();

      print("Response Status Code reply consult: ${response.statusCode}");
      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        // Parse the JSON response and find the reply for the specific consultId
        var replies = jsonDecode(responseData) as List;
        var reply = replies.firstWhere((reply) => reply['consult_id'] == consultId,
            orElse: () => null);

        if (reply != null) {
          message.value = reply['reply'];
          print("***********************************************");
          print(message.value);
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

