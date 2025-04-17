import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../TeacherApp/SendHomeworks/SubjectModel.dart';



class SubjectController extends GetxController {
  var subjects = <Subject>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchSubjects();
    super.onInit();
  }

  void fetchSubjects() async {
    try {
      isLoading(true);
      var response = await http.get(Uri.parse('http://127.0.0.1:8000/api/auth/student/student_showSubject'));
      if (response.statusCode == 200) {
        var data = json.decode(response.body) as List;
        subjects.value = data.map((subjectJson) => Subject.fromJson(subjectJson)).toList();
      } else {
        // handle error
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading(false);
    }
  }
}
