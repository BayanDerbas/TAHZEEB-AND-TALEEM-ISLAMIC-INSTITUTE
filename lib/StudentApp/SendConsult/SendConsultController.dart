import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sprint1/StudentApp/SendConsult/SendConsultModel.dart';

class ConsultController extends GetxController {
  var isAnonymous = false.obs;
  var consultText = ''.obs;
  var isLoading = false.obs;

  Future<void> sendConsult() async {
    isLoading.value = true;

    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    var queryParameters = {
      'adviser_id': '2', // Change this value as needed
      'student_id': '1', // Change this value as needed
      'consult': consultText.value,
      'is_anonymous': isAnonymous.value ? '1' : '0',
    };

    var uri = Uri.parse('http://127.0.0.1:8000/api/auth/student/student_sendConsult').replace(queryParameters: queryParameters);

    var request = http.Request('POST', uri);
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 201) {
        String responseBody = await response.stream.bytesToString();
        var jsonResponse = jsonDecode(responseBody);
        ConsultModel consultModel = ConsultModel.fromJson(jsonResponse['data']['consult']);
        print('Consultation request sent successfully: ${consultModel.consult}');
        Get.snackbar("نجاح", "تم الارسال بنجاح");

      } else {
        print('Error: ${response.reasonPhrase}');
        Get.snackbar("فشل", " فشل الارسال");
        consultText=" ".obs;
      }
    } catch (e) {
      print('Exception: $e');
    } finally {
      isLoading.value = false;
    }
  }

}
