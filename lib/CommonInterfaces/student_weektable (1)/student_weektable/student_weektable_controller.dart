import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sprint1/CommonInterfaces/student_weektable%20(1)/student_weektable/student_exam_table_model.dart';

import './student_weektable_model.dart';
import 'student_weektable_service.dart';

class StudentWeektableController extends GetxController {
  var isLoading = false.obs;
  var studentWeektable = <StudentWeektableModel>[].obs;
  var studentExamtable = <StudentExamTableModel>[].obs;
  List<bool> itemStatus = [true, false].obs;
  var days = <String, List<StudentWeektableModel>>{}.obs;
  List<bool> selectedDay = <bool>[].obs;
  var classroomId = 0;
  var selectedDayTitle = "".obs;

  @override
  void onInit() {
    super.onInit();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userData = prefs.getString('user_data');

    if (userData != null) {
      // تحويل سلسلة JSON إلى خريطة
      Map<String, dynamic> userMap = jsonDecode(userData);
      classroomId = userMap['user']['classroom_id'];
      fetchWeektable();
    } else {
      print("لم يتم العثور على بيانات المستخدم.");
      classroomId = 1;
      fetchWeektable();
    }
  }

  void fetchWeektable() async {
    try {
      isLoading(true);
      var studentWeektable =
          await StudentWeektableService().fetchWeektable(classroomId);
      this.studentWeektable.value = studentWeektable;
      days = <String, List<StudentWeektableModel>>{}.obs;
      for (var element in studentWeektable) {
        if (days[element.day] == null) days[element.day!] = [];
        days[element.day]!.add(element);
      }
      selectedDay = days.values.map((e) => false).toList();
      selectedDay[0] = true;
      selectedDayTitle.value = days.keys.elementAt(0);
    } finally {
      isLoading(false);
    }
  }

  void fetchExamtable() async {
    try {
      isLoading(true);
      var studentExamtable =
          await StudentWeektableService().fetchExamtable(classroomId);
      this.studentExamtable.value = studentExamtable;
    } finally {
      isLoading(false);
    }
  }
}
