import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sprint1/CommonInterfaces/student_weektable%20(1)/student_weektable/student_exam_table_model.dart';

import 'student_weektable_model.dart';

class StudentWeektableService {
  static const String url =
      'http://127.0.0.1:8000/api/auth/student/student_showWeekTableByClassroomId';
  static const String examUrl =
      'http://127.0.0.1:8000/api/auth/student/student_showExamTableByClassroomId';

  Future<List<StudentWeektableModel>> fetchWeektable(int id) async {
    print("$url?classroom_id=$id");
    final response = await http.post(Uri.parse("$url?classroom_id=$id"));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((post) => StudentWeektableModel.fromJson(post))
          .toList();
    } else {
      throw Exception('Failed to load degrees');
    }
  }

  Future<List<StudentExamTableModel>> fetchExamtable(int id) async {
    final response =
        await http.post(Uri.parse("$examUrl?classroom_id=$id"));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((post) => StudentExamTableModel.fromJson(post))
          .toList();
    } else {
      throw Exception('Failed to load degrees');
    }
  }
}
