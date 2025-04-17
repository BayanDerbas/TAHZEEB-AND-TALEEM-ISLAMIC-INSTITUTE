import 'dart:convert';

import 'package:http/http.dart' as http;

import 'classes_model.dart';

class MonitorHomeService {
  static const String url =
      'http://127.0.0.1:8000/api/auth/monitor/mentor_getClasses';

  Future<List<ClassesModel>> fetchClasses() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((post) => ClassesModel.fromJson(post)).toList();
    } else {
      throw Exception('Failed to load degrees');
    }
  }
}
