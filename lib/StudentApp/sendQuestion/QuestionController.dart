import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'QuestionModel.dart';

class QuestionController extends GetxController {
  var teacherAvailable = false.obs;
  var questionSent = false.obs;
  var errorMessage = ''.obs; // تخزين رسالة الخطأ

  Future<void> checkTeacherAvailability(int subjectId) async {
    // Implement the logic to check if the teacher is available for the subject
    // This is just a placeholder
    teacherAvailable.value = true;
  }

  Future<void> sendQuestion(QuestionModel question) async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };

    var body = jsonEncode({
      'subject_id': question.subjectId.toString(),
      'student_id': question.studentId.toString(),
      'question': question.question,
    });

    try {
      var response = await http.post(
        Uri.parse('http://127.0.0.1:8000/api/auth/student/student_askQuestion'),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonResponse = jsonDecode(response.body);
        print('Response data: ${response.body}'); // طباعة الاستجابة للتحقق
        print('Message from server: ${jsonResponse['message']}'); // طباعة الرسالة للتحقق

        if (jsonResponse['message'] == 'question sent successfully.') {
          questionSent.value = true;
          errorMessage.value = ''; // مسح رسالة الخطأ السابقة
          Get.snackbar("نجاح", "تم الارسال بنجاح");
        } else {
          questionSent.value = false;
          errorMessage.value = 'Failed to send question: ${jsonResponse['message']}';

        }
      } else {
        print('Error response: ${response.body}'); // طباعة استجابة الخطأ
        var jsonResponse = jsonDecode(response.body);
        questionSent.value = false;
        errorMessage.value = 'Failed to send question: ${jsonResponse['errors']?['teacher'] ?? 'Unknown error'}';
      }
    } catch (e) {
      print('Exception: $e'); // طباعة أي استثناءات قد تحدث
      questionSent.value = false;
      errorMessage.value = 'Exception: $e';
    }

    print('Question send status: ${questionSent.value}'); // طباعة حالة إرسال السؤال

    if (!questionSent.value) {
      Get.snackbar('Error', errorMessage.value); // عرض رسالة الخطأ في واجهة المستخدم
    }
  }
}


// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// import 'QuestionModel.dart';
//
// class QuestionController extends GetxController {
//   var teacherAvailable = false.obs;
//   var questionSent = false.obs;
//
//   Future<void> checkTeacherAvailability(int subjectId) async {
//     // Implement the logic to check if the teacher is available for the subject
//     // This is just a placeholder
//     teacherAvailable.value = true;
//   }
//
//   Future<void> sendQuestion(QuestionModel question) async {
//     var headers = {
//       'Accept': 'application/json',
//       'Content-Type': 'application/json'
//     };
//
//     var body = jsonEncode({
//       'subject_id': question.subjectId.toString(),
//       'student_id': question.studentId.toString(),
//       'question': question.question,
//     });
//
//     try {
//       var response = await http.post(
//         Uri.parse('http://127.0.0.1:8000/api/auth/student/student_askQuestion'),
//         headers: headers,
//         body: body,
//       );
//
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         var jsonResponse = jsonDecode(response.body);
//         print('Response data: ${response.body}'); // طباعة الاستجابة للتحقق
//         print('Message from server: ${jsonResponse['message']}'); // طباعة الرسالة للتحقق
//
//         if (jsonResponse['message'] == 'question sent successfully.') {
//           questionSent.value = true;
//         } else {
//           questionSent.value = false;
//         }
//       } else {
//         print('Error response: ${response.body}'); // طباعة استجابة الخطأ
//         questionSent.value = false;
//       }
//     } catch (e) {
//       print('Exception: $e'); // طباعة أي استثناءات قد تحدث
//       questionSent.value = false;
//     }
//
//     print('Question send status: ${questionSent.value}'); // طباعة حالة إرسال السؤال
//   }
// }
