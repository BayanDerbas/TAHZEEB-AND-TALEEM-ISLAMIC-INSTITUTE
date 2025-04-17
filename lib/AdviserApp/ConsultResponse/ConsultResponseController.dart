import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sprint1/AdviserApp/ConsultResponse/ConsultModel.dart';

class ConsultReplyController extends GetxController {
  var message = ''.obs;
  var textController = TextEditingController();
  var advisor = Rx<ConsultModel?>(null); // Assuming you're using ConsultModel for advisor
  var isLoading = false.obs;


  @override
  void onInit() {
    fetchConsult();
    super.onInit();
  }

  Future<void> sendMessage(int consultId, String replyText) async {
    String? accessToken;

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

      // Set headers for the request
      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      };

      // Send the reply to the server
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/api/auth/adviser/adviser_replyToConsult?consult_id=$consultId&reply=$replyText  '),
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

  Future<void> fetchReplyByConsultId(int consultId) async {
    print("bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb");
    isLoading(true);
    try {
      var request = http.Request('GET', Uri.parse('http://127.0.0.1:8000/api/auth/adviser/adviser_showConsultReplies'));

      http.StreamedResponse response = await request.send();

      print("bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb${response.statusCode}");
      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        // Parse the JSON response and find the reply for the specific consultId
        var replies = jsonDecode(responseData) as List;
        var reply = replies.firstWhere((reply) => reply['consult_id'] == consultId, orElse: () => null);

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


  Future<void> fetchConsult() async {
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


