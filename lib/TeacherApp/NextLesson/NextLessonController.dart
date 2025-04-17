import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'NextLessonmodel.dart';

class LessonController extends GetxController {
  var nextLesson = Lesson(day: '', startTime: '', endTime: '', classroom: '').obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNextLesson();
  }

  String? accessToken;

  Future<void> fetchToken() async {

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


  void fetchNextLesson() async {
    await fetchToken();
    try {
      isLoading(true);
      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      };
      var request = http.Request(
        'GET',
        Uri.parse('http://127.0.0.1:8000/api/auth/teacher/teacher_getNextLessonForTeacher'),
      );
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        var jsonData = json.decode(responseData);

        if (jsonData is Map && jsonData.containsKey('day')) {
          nextLesson.value = Lesson.fromJson(jsonData.cast<String, dynamic>());
        } else {
          errorMessage.value = jsonData.toString(); // Handle any message from the API
        }
      } else {
        errorMessage.value = response.reasonPhrase ?? 'Failed to load lesson data';
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading(false);
    }
  }
}
