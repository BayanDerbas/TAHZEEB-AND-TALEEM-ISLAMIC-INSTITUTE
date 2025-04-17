import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sprint1/TeacherApp/teacher_weektable/teacher_weektable/teacher_monitoring_table_model.dart';

import 'teacher_weektable_model.dart';

class TeacherWeektableService {
  static const String url =
      'http://127.0.0.1:8000/api/auth/teacher/teacher_showWeekTable';
  static const String monitoringUrl =
      'http://127.0.0.1:8000/api/auth/teacher/teacher_showMonitoringTable';

  Future<List<TeacherWeekTableModel>> fetchWeektable(String token) async {
    final response = await http
        .get(Uri.parse(url), headers: {"Authorization": "Bearer $token"});

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((post) => TeacherWeekTableModel.fromJson(post))
          .toList();
    } else {
      throw Exception('Failed to load degrees');
    }
  }

  Future<List<TeacherMonitoringTable>> fetchMonitoring(String token) async {
    final response = await http.get(Uri.parse(monitoringUrl),
        headers: {"Authorization": "Bearer $token"});

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((post) => TeacherMonitoringTable.fromJson(post))
          .toList();
    } else {
      throw Exception('Failed to load degrees');
    }
  }
}
