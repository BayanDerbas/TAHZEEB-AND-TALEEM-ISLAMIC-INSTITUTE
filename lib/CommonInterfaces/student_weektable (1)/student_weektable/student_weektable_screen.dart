import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'student_weektable_controller.dart';

class StudentWeektableScreen extends StatefulWidget {
  final int classroomId;
  const StudentWeektableScreen({super.key, this.classroomId = 1});

  @override
  State<StudentWeektableScreen> createState() => _StudentWeektableScreenState();
}

class _StudentWeektableScreenState extends State<StudentWeektableScreen> {
  List<String> itemTitle = ["الدوام", "الامتحان"];

  final StudentWeektableController studentWeektableController =
      Get.put(StudentWeektableController());
  var timings = [
    "8:00 - 8:45",
    "8:45 - 9:30",
    "9:45 - 10:30",
    "10:30 - 11:15",
    "11:30 - 12:15",
    "12:15 - 1:00",
    "1:00 - 1:45"
  ];

  Map<String, String> rows = <String, String>{
    'الشفهي': '100%',
    'الوظائف': '100%',
    'مشاركة': '100%',
    'نشاط': '100%',
    'مذاكرة': '100%',
    'امتحان': '100%',
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الجداول المدرسية'),
        centerTitle: true,

      ),
      body: Obx(() {
        if (studentWeektableController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        // تأكد من أن بيانات الجدول موجودة وليست null قبل المتابعة
        if (studentWeektableController.days.isEmpty) {
          return const Center(child: Text('No data available.'));
        }
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ToggleButtons(
                    renderBorder: false,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    isSelected: studentWeektableController.itemStatus,
                    onPressed: (int index) {
                      for (int i = 0;
                          i < studentWeektableController.itemStatus.length;
                          i++) {
                        studentWeektableController.itemStatus[i] = false;
                      }
                      studentWeektableController.itemStatus[index] = true;

                      if (index == 0) {
                        studentWeektableController.fetchWeektable();
                      } else {
                        studentWeektableController.fetchExamtable();
                      }
                    },
                    fillColor: Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    selectedColor: Colors.white,
                    children: List<Widget>.generate(
                      2,
                      (index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 5),
                            decoration: BoxDecoration(
                              color:
                                  studentWeektableController.itemStatus[index]
                                      ? Colors.amber
                                      : Colors.white,
                              border: Border.all(color: Colors.amber, width: 3),
                              borderRadius: BorderRadius.circular(500),
                            ),
                            child: Text(
                              itemTitle[index],
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Center(
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (studentWeektableController.itemStatus[0])
                          ToggleButtons(
                            fillColor: Colors.yellow.shade700,
                            selectedColor: Colors.black,
                            // ToggleButtons uses a List<bool> to track its selection state.
                            isSelected: studentWeektableController.selectedDay,
                            // This callback return the index of the child that was pressed.
                            onPressed: (int index) {
                              for (int i = 0;
                                  i <
                                      studentWeektableController
                                          .selectedDay.length;
                                  i++) {
                                studentWeektableController.selectedDay[i] =
                                    false;
                              }
                              studentWeektableController.selectedDay[index] =
                                  true;
                              studentWeektableController
                                      .selectedDayTitle.value =
                                  studentWeektableController.days.keys
                                      .elementAt(index);
                            },
                            // Constraints are used to determine the size of each child widget.
                            constraints: const BoxConstraints(
                              minHeight: 32.0,
                              minWidth: 56.0,
                            ),
                            // ToggleButtons uses a List<Widget> to build its children.
                            children: studentWeektableController.days
                                .map((key, value) {
                                  return MapEntry(
                                      key,
                                      Text(
                                        key,
                                        style: const TextStyle(fontSize: 17),
                                      ));
                                })
                                .values
                                .toList(),
                          ),
                        SizedBox(
                          width: double.infinity,
                          child: DataTable(
                            columns: const [
                              DataColumn(label: Text('المادة')),
                              DataColumn(label: Text('التوقيت')),
                            ],
                            rows: studentWeektableController.itemStatus[0]
                                ? List<DataRow>.generate(
                                    studentWeektableController
                                        .days[studentWeektableController
                                            .selectedDayTitle.value]!
                                        .length, // the +1 is for the header row
                                    (int index) {
                                      return DataRow(
                                          cells: [
                                            DataCell(Text(
                                              studentWeektableController
                                                  .days[
                                                      studentWeektableController
                                                          .selectedDayTitle
                                                          .value]![index]
                                                  .subjectName!,
                                              textAlign: TextAlign.start,
                                            )),
                                            DataCell(Text(
                                              timings[index],
                                              textAlign: TextAlign.center,
                                            )),
                                          ],
                                          color: WidgetStateProperty.all(
                                              index.isEven
                                                  ? Colors.white
                                                  : Colors.grey.shade200));
                                    },
                                  )
                                : List<DataRow>.generate(
                                    studentWeektableController.studentExamtable
                                        .length, // the +1 is for the header row
                                    (int index) {
                                      return DataRow(
                                          cells: [
                                            DataCell(Text(
                                              studentWeektableController
                                                  .studentExamtable[index]
                                                  .subjectName!,
                                              textAlign: TextAlign.center,
                                            )),
                                            DataCell(Text(
                                                "${DateFormat('yyyy-MM-dd').format(studentWeektableController.studentExamtable[index].examDate!)}"
                                            )
                                            ),
                                          ],
                                          color: WidgetStateProperty.all(
                                              index.isEven
                                                  ? Colors.white
                                                  : Colors.grey.shade200));
                                    },
                                  ),
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 4,
                                    offset: const Offset(
                                        0, 1), // changes position of shadow
                                  ),
                                ]),
                            border: TableBorder(
                                borderRadius: BorderRadius.circular(15)),
                            dataTextStyle: const TextStyle(fontSize: 16),
                            headingTextStyle: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
