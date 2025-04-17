import 'dart:convert';

import 'package:http/http.dart' as http;

import 'first_and_ranks_model.dart';

class FirstsAndRanksService {
  static const String url =
      'http://127.0.0.1:8000/api/auth/student/student_getStudentsSortedByMarks';

  Future<List<FirstsAndRanksModel>> fetchFirstAndRanks() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      print(jsonResponse);
      return jsonResponse
          .map((post) => FirstsAndRanksModel.fromJson(post))
          .toList();
    } else {
      throw Exception('Failed to load firstsAndRanksModel');
    }
  }
}
