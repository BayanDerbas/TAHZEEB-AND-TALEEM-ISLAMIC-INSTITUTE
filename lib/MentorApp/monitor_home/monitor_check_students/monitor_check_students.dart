import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sprint1/color_.dart';

import 'monitor_check_students_controller.dart';
import 'widgets/students_questions_gray_box_group.dart';

class MonitorCheckStudents extends StatefulWidget {
  final int classroomId;
  const MonitorCheckStudents({super.key, required this.classroomId});

  @override
  State<MonitorCheckStudents> createState() => _MonitorCheckStudentsState();
}

class _MonitorCheckStudentsState extends State<MonitorCheckStudents> {
  late final MonitorCheckStudentsController monitorCheckStudentsController;

  @override
  void initState() {
    monitorCheckStudentsController = Get.put(MonitorCheckStudentsController());
    monitorCheckStudentsController.classroomId = widget.classroomId;
    monitorCheckStudentsController.fetchDegrees();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("تفقد الطلاب"), centerTitle: true),
      backgroundColor: Colors.white,
      body: Obx(() {
        if (monitorCheckStudentsController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if(monitorCheckStudentsController.students==null ||
        monitorCheckStudentsController.students.value.checkListAttendance==null ||
        monitorCheckStudentsController.students.value.checkListAttendance!.isEmpty
        ){
          return const Center(
            child: Text('No students found'), // رسالة تُعرض عند عدم وجود بيانات
          );
        }

        return Center(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(15),
                  children: [
                    if (monitorCheckStudentsController
                            .students.value.checkListAttendance!.length >
                        0)
                      StudentsQuestionsGrayBoxGroup(title: "لوحة الشرف"),
                    if (monitorCheckStudentsController
                            .students.value.checkListAttendance!.length ==
                        0)
                      Center(child: Text("لا يوجد طلاب ضمن الصف")),
                    SizedBox(
                      height: 20,
                    ),
                    if (monitorCheckStudentsController
                            .students.value.checkListAttendance!.length >
                        0)
                      ElevatedButton(
                        onPressed: () async {
                          await monitorCheckStudentsController.markAttendance();
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("تم الإرسال بنجاح"),
                          ));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: color_.yellow,
                          disabledBackgroundColor: Colors.black,
                         disabledForegroundColor: Colors.grey.shade500,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 5),
                        ),
                        child: const Text(
                          'ارسال التفقد',
                          style: TextStyle(fontSize: 24,color: Colors.black54),
                        ),
                      )
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
