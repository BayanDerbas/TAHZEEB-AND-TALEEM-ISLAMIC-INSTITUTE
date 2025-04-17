import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'student_degrees_service.dart';
import 'package:sprint1/CommonInterfaces/student_degrees/student_degrees/student_degrees_model.dart';

class StudentDegreesController extends GetxController {
  var studentId = 0;
  var isLoading = false.obs;
  var studentDegrees = StudentDegreesModel().obs;
  var quizzes = <String, Map<Subjects, int>>{}.obs;
  List<bool> selectedQuiz = <bool>[].obs;

  var selectedQuizTitle = "".obs;

  @override
  void onInit() {
    super.onInit();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userData = prefs.getString('user_data');

    if (userData != null) {
      String? userType = prefs.getString('user_type');

      Map<String, dynamic> userMap;
      try {
        userMap = jsonDecode(userData);
      } catch (e) {
        print("Error parsing user data: $e");
        return;
      }

      if (userType == "parent") {
        // Ensure 'student_id' exists and is not null
        studentId = userMap['user']['student_id'];
      } else {
        // Ensure 'id' exists and is not null
        studentId = userMap['user']['id'];
      }

      fetchDegrees();

    } else {
      print("No user data found.");
      studentId = 1; // Default value or handle as needed
      fetchDegrees();
    }
  }


  void fetchDegrees() async {
    try {
      isLoading(true);
      var studentDegrees =
          await StudentDegreesService().fetchDegrees(studentId);
      this.studentDegrees.value = studentDegrees;
      print(studentDegrees);
      quizzes = <String, Map<Subjects, int>>{}.obs;
      studentDegrees.subjects?.forEach((element1) {
        element1.quizzes?.forEach((element) {
          if (quizzes[element.type] == null) {
            quizzes[element.type!] = <Subjects, int>{};
          }
          quizzes[element.type]![element1] = element.finalMark!;
        });
      });
      selectedQuiz = quizzes.values.map((e) => false).toList();
      selectedQuiz[0] = true;
      selectedQuizTitle.value = quizzes.keys.elementAt(0);
    } finally {
      isLoading(false);
    }
  }
}
