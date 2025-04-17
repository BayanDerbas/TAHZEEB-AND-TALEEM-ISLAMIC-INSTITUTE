import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './teacher_weektable_model.dart';
import 'teacher_monitoring_table_model.dart';
import 'teacher_weektable_service.dart';

class TeacherWeekTableController extends GetxController {
  var isLoading = false.obs;
  var teacherWeekTable = <TeacherWeekTableModel>[].obs;
  var teacherMonitoringTable = <TeacherMonitoringTable>[].obs;
  List<bool> itemStatus = [true, false].obs;
  var days = <String, List<TeacherWeekTableModel>>{}.obs;
  List<bool> selectedDay = <bool>[].obs;
  var token = "";
  var selectedDayTitle = "".obs;

  @override
  void onInit() {
    super.onInit();
    _loadUserData();
  }
  var accessToken;

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userData = prefs.getString('user_data');

    if (userData != null) {
      // تحويل سلسلة JSON إلى خريطة
      Map<String, dynamic> userMap = jsonDecode(userData);
      accessToken = userMap['access_token'];
      print('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%$accessToken');
      fetchWeekTable();
    } else {
      print("لم يتم العثور على بيانات المستخدم.");
      accessToken =
          "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTI3LjAuMC4xOjgwMDAvYXBpL2F1dGgvdGVhY2hlci9sb2dpbiIsImlhdCI6MTcyMzQ3NjkyMywiZXhwIjoxNzIzNDgwNTIzLCJuYmYiOjE3MjM0NzY5MjMsImp0aSI6IlQ3T0EzY2hheDl1VW1uQzkiLCJzdWIiOiIxIiwicHJ2IjoiYjI3YmVlMjNiYWY1NDI5ZjViOWEyMTY5NmZkZTAzYzI3NzA0NGVhNSJ9.Jz8KmjJ_HWj16pncyOca32Bvszhdj_JW_VZD6F6ENmQ";
      fetchWeekTable();
    }
  }

  void fetchWeekTable() async {
    try {
      isLoading(true);
      var teacherWeekTable =
          await TeacherWeektableService().fetchWeektable(accessToken);
      this.teacherWeekTable.value = teacherWeekTable;
      days = <String, List<TeacherWeekTableModel>>{}.obs;
      for (var element in teacherWeekTable) {
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

  void fetchMonitoringTable() async {
    try {
      isLoading(true);
      var teacherMonitoringTable =
          await TeacherWeektableService().fetchMonitoring(accessToken);
      this.teacherMonitoringTable.value = teacherMonitoringTable;
    } finally {
      isLoading(false);
    }
  }
}
