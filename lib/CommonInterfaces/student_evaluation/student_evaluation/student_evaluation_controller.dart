import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sprint1/CommonInterfaces/student_evaluation/student_evaluation/student_taqsim_model.dart';

import 'student_degrees_model.dart';
import 'student_evaluation_service.dart';

class StudentEvaluationController extends GetxController {
  var studentId = 0;
  var finalValue = 0.0.obs;
  var isLoading = false.obs;
  var studentDegrees = StudentDegreesModel().obs;
  var studentTaqsim = StudentTaqsimModel().obs;
  List<bool> itemStatus = [true, false].obs;

  Map<String, String> rows = <String, String>{
    'الشفهي': '100%',
    'الوظائف': '100%',
    'مشاركة': '100%',
    'نشاط': '100%',
    'مذاكرة': '100%',
    'امتحان': '100%',
  };

  @override
  void onInit() {
    super.onInit();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userData = prefs.getString('user_data');

    if (userData != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userType = prefs.getString('user_type');

      if(userType=="parent"){
        print("parent app");
        Map<String, dynamic> userMap = jsonDecode(userData);
        studentId = userMap['user']['student_id'];
        fetchTaqsim(studentId);
        fetchDegrees(studentId);
      }else{
        Map<String, dynamic> userMap = jsonDecode(userData);
        studentId = userMap['user']['id'];
        fetchTaqsim(studentId);
        fetchDegrees(studentId);
      }

    } else {
      print("لم يتم العثور على بيانات المستخدم.");
      studentId = 1;
      fetchTaqsim(studentId);
      fetchDegrees(studentId);
    }
    print("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
    print("$studentId");
  }

  void fetchDegrees(int id) async {
    try {
      isLoading(true);
      var studentDegrees = await StudentEvaluationService().fetchDegrees(id);
      this.studentDegrees.value = studentDegrees;
      finalValue = 0.0.obs;
      for (int i = 0; i < studentDegrees.subjects!.length; i++) {
        finalValue.value += studentDegrees.subjects![i].averageMark!;
      }
      finalValue.value = finalValue.value / studentDegrees.subjects!.length;
    } finally {
      isLoading(false);
    }
  }

  void fetchTaqsim(int id) async {
    try {
      isLoading(true);
      var studentTaqsim = await StudentEvaluationService().fetchTaqsim(id);
      this.studentTaqsim.value = studentTaqsim;
      finalValue = 0.0.obs;
      finalValue.value += studentTaqsim.active!;
      finalValue.value += studentTaqsim.exam!;
      finalValue.value += studentTaqsim.oral!;
      finalValue.value += studentTaqsim.written!;
      finalValue.value += studentTaqsim.participation!;
      finalValue.value += studentTaqsim.quiz!;
      finalValue.value = (finalValue.value / 6).roundToDouble();

      rows = <String, String>{
        'الشفهي': "${studentTaqsim.oral} %",
        'الوظائف': "${studentTaqsim.written} %",
        'مشاركة': "${studentTaqsim.participation} %",
        'نشاط': "${studentTaqsim.active} %",
        'مذاكرة': "${studentTaqsim.quiz} %",
        'امتحان': "${studentTaqsim.exam} %",
      };
    } finally {
      isLoading(false);
    }
  }
}
