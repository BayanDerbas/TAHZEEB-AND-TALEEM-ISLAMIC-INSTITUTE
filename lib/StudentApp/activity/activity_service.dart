// import 'dart:convert';
//
// import 'package:http/http.dart' as http;
//
// import 'activity_model.dart';
//
// class ActivityService {
//   static const String url =
//       'http://127.0.0.1:8000/api/auth/student/student_showEntertainmentQuiz';
//   Future<ActivityModel> fetchActivity() async {
//     final response = await http.get(Uri.parse(url));
//
//     print("888888888888888888888888");
//     print(response.statusCode);
//     try{
//     if (response.statusCode == 200) {
//       List jsonResponse = json.decode(response.body);
//       return jsonResponse
//           .map((post) => ActivityModel.fromJson(post))
//           .toList()
//           .last;
//     } else {
//       throw Exception('Failed to load activity');
//     }}catch(e){
//       print(e);
//     }
//
//   }
// }
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'activity_model.dart';

class ActivityService {
  static const String url =
      'http://127.0.0.1:8000/api/auth/student/student_showEntertainmentQuiz';

  Future<ActivityModel?> fetchActivity() async {
    try {
      final response = await http.get(Uri.parse(url));

      print("Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);

        // Assuming the response is a single activity
        return ActivityModel.fromJson(jsonResponse);
      } else {
        print('Failed to load activity. Status code: ${response.statusCode}');
        return null; // Or handle as you prefer
      }
    } catch (e) {
      print('Exception occurred: $e');
      return null; // Or handle as you prefer
    }
  }
}

