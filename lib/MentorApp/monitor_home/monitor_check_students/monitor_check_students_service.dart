import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sprint1/MentorApp/monitor_home/monitor_check_students/students_model.dart';

class MonitorCheckStudentsService {
  static const String url =
      'http://127.0.0.1:8000/api/auth/monitor/mentor_showStudent';

  static const String urlMarkAttendance =
      'http://127.0.0.1:8000/api/auth/monitor/mentor_markAttendance';

  Future<StudentsModel> fetchStudents(int id, String token) async {
    final response = await http.post(Uri.parse("$url?classroom_id=$id"),
        headers: {"Authorization": "Bearer $token"});
    print(token);
    print(Uri.parse("$url?classroom_id=$id"));
    if (response.statusCode == 200) {
      return StudentsModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load degrees');
    }
  }

  Future<StudentsModel> saveAttendance(
      {required int classroomId,
      required int studentId,
      required int departmentId,
      required String attendanceStatus,
      required DateTime attendanceDate,
      required String token}) async {
    final response = await http.post(
        Uri.parse(
            "$urlMarkAttendance?classroom_id=$classroomId&student_id=$studentId&department_id=$departmentId&attendance_status=$attendanceStatus&attendance_date=$attendanceDate"),
        headers: {"Authorization": "Bearer $token"});
    print(json.decode(response.body));
    if (response.statusCode == 201) {
      return StudentsModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load degrees');
    }
  }
}
