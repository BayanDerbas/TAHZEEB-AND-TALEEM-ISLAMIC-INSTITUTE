import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class TeacherAttendanceController extends GetxController {
  var isLoading = false.obs;
  var attendanceMessage = ''.obs;

  Future<void> markAttendance(String teacherId) async {
    try {
      isLoading(true);

      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      };

      var request = http.Request(
          'POST',
          Uri.parse(
              'http://127.0.0.1:8000/api/auth/monitor/mentor_checkTeacherAttendance?teacher_id=$teacherId'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();


      print("*************************************************");
      print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode==201) {
        var responseData = await response.stream.bytesToString();
        var jsonResponse = json.decode(responseData);
        print(jsonResponse);

        if(jsonResponse['message']!=null){
        if ( jsonResponse['message'] == "تم تسجيل حضور هذا المعلم مسبقًا") {
          attendanceMessage.value = "تم تسجيل حضور هذا المعلم مسبقًا";
          // عرض Snackbar عندما يكون المعلم قد تم تسجيل حضوره مسبقًا
          Get.snackbar(
            "تنبيه",
            jsonResponse['message'],
            snackPosition: SnackPosition.BOTTOM,
          );
        } else if(jsonResponse['message']=="تم تسجيل حضور المعلم بنجاح") {
          Get.snackbar(
            "تم",
            jsonResponse['message'],
            snackPosition: SnackPosition.BOTTOM,
          );
          attendanceMessage.value =
          "تم تسجيل حضور المعلم ${jsonResponse['teacher']['first_name']} ${jsonResponse['teacher']['last_name']} بنجاح بتاريخ ${jsonResponse['attendance']['attendance_date']}";
        }
      }
      }else {
        attendanceMessage.value = "فشل تسجيل الحضور";
      }
    } catch (e) {
      print("errooooooooooooor $e");
      attendanceMessage.value = "حدث خطأ أثناء تسجيل الحضور";
    } finally {
      isLoading(false);
    }
  }
}
