import 'dart:convert';
import 'package:sprint1/CommonInterfaces/student_degrees/student_degrees/student_degrees_model.dart';

import 'package:http/http.dart' as http;

class StudentDegreesService {
  static const String url =
      'http://127.0.0.1:8000/api/auth/student/student_showDegrees';

  Future<StudentDegreesModel> fetchDegrees(int id) async {
    final response = await http.get(Uri.parse("$url?student_id=$id"));
    print("$url?student_id=$id");
    if (response.statusCode == 200) {
      return StudentDegreesModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load degrees');
    }
  }
}
