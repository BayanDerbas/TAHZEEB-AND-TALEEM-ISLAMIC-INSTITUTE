import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sprint1/CommonInterfaces/student_evaluation/student_evaluation/student_taqsim_model.dart';

import 'student_degrees_model.dart';

class StudentEvaluationService {
  static const String url =
      'http://127.0.0.1:8000/api/auth/student/student_showDegrees';

  static const String taqsimUrl =
      'http://127.0.0.1:8000/api/auth/student/student_showTaqsimDegree';

  Future<StudentDegreesModel> fetchDegrees(int id) async {
    final response = await http.get(Uri.parse("$url?student_id=$id"));

    if (response.statusCode == 200) {
      return StudentDegreesModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load degrees');
    }
  }

  Future<StudentTaqsimModel> fetchTaqsim(int id) async {
    final response = await http.get(Uri.parse("$taqsimUrl?student_id=$id"));

    if (response.statusCode == 200) {
      return StudentTaqsimModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load degrees');
    }
  }
}
