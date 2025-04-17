import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sprint1/CommonInterfaces/student_degrees/student_degrees/student_degrees_controller.dart';

class StudentDegreesScreen extends StatefulWidget {
  const StudentDegreesScreen({super.key});

  @override
  State<StudentDegreesScreen> createState() => _StudentDegreesScreenState();
}

class _StudentDegreesScreenState extends State<StudentDegreesScreen> {
  final StudentDegreesController studentDegreesController =
      Get.put(StudentDegreesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('درجات الطالب',style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.green,
          centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: () {
            Get.back();
            // يمكنك إضافة الوظيفة التي ترغب بها عند الضغط على السهم هنا
          },
        ),),
      body: Obx(() {
        if (studentDegreesController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        // Check if quizzes are empty or selectedQuizTitle is null
        if (studentDegreesController.quizzes.isEmpty) {
          return const Center(child: Text('No data available'));
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Center(
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ToggleButtons(
                          fillColor: Colors.yellow.shade700,
                          selectedColor: Colors.black,
                          // ToggleButtons uses a List<bool> to track its selection state.
                          isSelected: studentDegreesController.selectedQuiz,
                          // This callback return the index of the child that was pressed.
                          onPressed: (int index) {
                            for (int i = 0;
                                i <
                                    studentDegreesController
                                        .selectedQuiz.length;
                                i++) {
                              studentDegreesController.selectedQuiz[i] = false;
                            }
                            studentDegreesController.selectedQuiz[index] = true;
                            studentDegreesController.selectedQuizTitle.value =
                                studentDegreesController.quizzes.keys
                                    .elementAt(index);
                          },
                          // Constraints are used to determine the size of each child widget.
                          constraints: const BoxConstraints(
                            minHeight: 32.0,
                            minWidth: 56.0,
                          ),
                          // ToggleButtons uses a List<Widget> to build its children.
                          children: studentDegreesController.quizzes
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
                        const SizedBox(height: 20,),
                        SizedBox(
                          width: double.infinity,
                          child: DataTable(
                            columns: const [
                              DataColumn(label: Text('المادة')),
                              DataColumn(label: Text('عظمى')),
                              DataColumn(label: Text('صغرى')),
                              DataColumn(label: Text('مستحقة')),
                            ],
                            rows: List<DataRow>.generate(
                              studentDegreesController
                                  .quizzes[studentDegreesController
                                      .selectedQuizTitle.value]!
                                  .length, // the +1 is for the header row
                              (int index) {
                                return DataRow(
                                    cells: [
                                      DataCell(Text(
                                        studentDegreesController
                                            .quizzes[studentDegreesController
                                                .selectedQuizTitle.value]!
                                            .keys
                                            .elementAt(index)
                                            .name!,
                                        textAlign: TextAlign.start,
                                      )),
                                      const DataCell(Text(
                                        "100%",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(color: Colors.green),
                                      )),
                                      const DataCell(Text(
                                        "0%",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(color: Colors.red),
                                      )),
                                      DataCell(Text(
                                        "${studentDegreesController
                                                .quizzes[
                                                    studentDegreesController
                                                        .selectedQuizTitle
                                                        .value]!
                                                .values
                                                .elementAt(index)}%",
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
