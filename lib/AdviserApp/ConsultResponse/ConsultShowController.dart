import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:sprint1/AdviserApp/ConsultResponse/ConsultModel.dart';


class ConsultShowController extends GetxController {
  var consultations = <ConsultModel>[].obs;
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


  void fetchConsultationById(int consultId) async {
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
      Uri.parse('http://127.0.0.1:8000/api/auth/adviser/adviser_getConsultById?id=$consultId'),
      headers: headers,
    );

    print("Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      // هنا نتعامل مع كائن JSON وليس قائمة
      var jsonResponse = json.decode(response.body) as Map<String, dynamic>;

      var consultation = ConsultModel.fromJson(jsonResponse);
      consultations.value = [consultation];  // نقوم بتحديث القائمة بإضافة الاستشارة المفردة

      print("Consultation loaded successfully.");
    } else {
      // معالجة الخطأ
      print('Failed to load consultation');
    }
  }

  void sendMessage(int adviserId, int consultId) {
    if (textController.text.trim().isNotEmpty) {
      message.value = textController.text.trim();
      // Here you would send the message to the server.
    }
  }




  }


