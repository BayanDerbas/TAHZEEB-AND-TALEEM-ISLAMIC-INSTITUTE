import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';



class NoteController extends GetxController {
  var isAnonymous = false.obs;
  var noteText = ''.obs;
  var isLoading = false.obs;

  Future<Map<String, int?>> fetchIdsFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userData = prefs.getString('user_data');

    int? studentId;
    int? classroomId;

    if (userData != null) {
      var userJson = json.decode(userData);
      studentId = userJson['user']['id'] as int?;
      print(" parent id :$studentId ");
    }


    return {'student_id': studentId};
  }


  Future<void> sendNote() async {
    isLoading.value = true;

    try {
      var ids = await fetchIdsFromPrefs();
      int? parentId = ids['student_id'];  // Corrected variable name to lowercase 'parentId'

      if (parentId == null) {
        print("Parent ID is null.");
        return;
      }

      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };

      var uri = Uri.parse(
          'http://127.0.0.1:8000/api/auth/parent/student_sendNote?parent_id=$parentId&note=${Uri.encodeComponent(noteText.value)}');

      var request = http.Request('POST', uri);
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      print("ssssssssssssssssssssss${response.statusCode}");

      if (response.statusCode == 201) {
        String responseBody = await response.stream.bytesToString();
        print('Response body: $responseBody');  // Debugging line to inspect the response

        var jsonResponse = jsonDecode(responseBody);

        if (jsonResponse['message'] != null) {
          print('Note sent successfully: ${jsonResponse['message']}');
          Get.snackbar("","تم ارسال الملاحظة بنجاح الى الادارة");
        } else {
          print('Error: Response does not contain a message.');
        }
      } else {
        print('Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Exception: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
