import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sprint1/color_.dart';

import 'student_evaluation_controller.dart';

class StudentEvaluationScreen extends StatefulWidget {
  final int studentId;
  const StudentEvaluationScreen({super.key, this.studentId = 1});

  @override
  State<StudentEvaluationScreen> createState() =>
      _StudentEvaluationScreenState();
}

class _StudentEvaluationScreenState extends State<StudentEvaluationScreen> {
  List<String> itemTitle = ["التقسيم", "المواد"];

  final StudentEvaluationController studentEvaluationController =
      Get.put(StudentEvaluationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تقييم الطالب'),centerTitle: true,backgroundColor: color_.green,),
      body: Obx(() {
        if (studentEvaluationController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
                    isSelected: studentEvaluationController.itemStatus,
                    onPressed: (int index) {
                      for (int i = 0;
                          i < studentEvaluationController.itemStatus.length;
                          i++) {
                        studentEvaluationController.itemStatus[i] = false;
                      }
                      studentEvaluationController.itemStatus[index] = true;

                      if (index == 1) {
                        studentEvaluationController;
                      } else {
                        studentEvaluationController;
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
                                  studentEvaluationController.itemStatus[index]
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
              SizedBox(height: 30),
              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('المادة')),
                      DataColumn(label: Text('%')),
                    ],
                    rows: studentEvaluationController.itemStatus[1]
                        ? List<DataRow>.generate(
                            studentEvaluationController
                                .studentDegrees
                                .value
                                .subjects!
                                .length, // the +1 is for the header row
                            (int index) {
                              return DataRow(
                                  cells: [
                                    DataCell(Text(
                                      studentEvaluationController
                                          .studentDegrees
                                          .value
                                          .subjects![index]
                                          .name!,
                                      textAlign: TextAlign.start,
                                    )),
                                    DataCell(Text(
                                      "${studentEvaluationController.studentDegrees.value.subjects![index].averageMark}%",
                                      textAlign: TextAlign.center,
                                    )),
                                  ],
                                  color: WidgetStateProperty.all(index.isEven
                                      ? Colors.white
                                      : Colors.grey.shade200));
                            },
                          )
                        : List<DataRow>.generate(
                            studentEvaluationController
                                .rows.length, // the +1 is for the header row
                            (int index) {
                              return DataRow(
                                  cells: [
                                    DataCell(Text(
                                      studentEvaluationController.rows.keys
                                          .elementAt(index),
                                      textAlign: TextAlign.start,
                                    )),
                                    DataCell(Text(
                                      studentEvaluationController.rows.values
                                          .elementAt(index),
                                      textAlign: TextAlign.center,
                                    )),
                                  ],
                                  color: WidgetStateProperty.all(index.isEven
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
                            offset:
                                const Offset(0, 1), // changes position of shadow
                          ),
                        ]),
                    border:
                        TableBorder(borderRadius: BorderRadius.circular(15)),
                    dataTextStyle: const TextStyle(fontSize: 16),
                    headingTextStyle: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  'المعدل الكلي للطالب: ${studentEvaluationController.finalValue}%',
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
