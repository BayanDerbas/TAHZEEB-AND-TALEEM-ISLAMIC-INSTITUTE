// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import '../data/dataSourse/staticList.dart';
// import 'SendHomeworksController.dart';
//
// class SendHomeworks extends StatefulWidget {
//   const SendHomeworks({super.key});
//
//   @override
//   State<SendHomeworks> createState() => _SendHomeworksState();
// }
//
// class _SendHomeworksState extends State<SendHomeworks> {
//   final HomeworkController controller = Get.put(HomeworkController());
//   String? typeValue;
//   DateTime? selectedDate;
//
//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: selectedDate ?? DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );
//     if (picked != null && picked != selectedDate) {
//       setState(() {
//         selectedDate = picked;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color.fromRGBO(29, 122, 67, 1),
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             const Text(
//               'تحديد مقرر دراسي ',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(width: 40),
//             Container(
//               margin: const EdgeInsets.symmetric(vertical: 10),
//               child: Image.asset(
//                 'assets/homeworks.png',
//                 height: 80,
//               ),
//             ),
//           ],
//         ),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             // يمكنك إضافة الوظيفة التي ترغب بها عند الضغط على السهم هنا
//           },
//         ),
//       ),
//       body: Center(
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 margin: const EdgeInsets.all(16),
//                 padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color: const Color.fromRGBO(227, 227, 227, 1.0),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.5),
//                       spreadRadius: 2,
//                       blurRadius: 5,
//                       offset: const Offset(0, 3),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   children: [
//                     const Text("يرجى إدخال المعلومات المطلوبة:"),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Obx(() {
//                         return DropdownButton(
//                           hint: const Text("اختر الصف"),
//                           isExpanded: true,
//                           value: controller.selectedClassroomId.value == 0
//                               ? null
//                               : controller.selectedClassroomId.value,
//                           items: controller.classrooms.map((classroom) {
//                             return DropdownMenuItem(
//                               value: classroom.id,
//                               child: Text(classroom.name),
//                             );
//                           }).toList(),
//                           onChanged: (newValue) {
//                             controller.selectedClassroomId.value = newValue as int;
//                             controller.fetchSubjects(newValue);
//                           },
//                         );
//                       }),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Obx(() {
//                         return DropdownButton(
//                           hint: const Text("اختر المادة"),
//                           isExpanded: true,
//                           value: controller.selectedSubjectId.value == 0
//                               ? null
//                               : controller.selectedSubjectId.value,
//                           items: controller.subjects.map((subject) {
//                             return DropdownMenuItem(
//                               value: subject.id,
//                               child: Text(subject.name),
//                             );
//                           }).toList(),
//                           onChanged: (newValue) {
//                             controller.selectedSubjectId.value = newValue as int;
//                           },
//                         );
//                       }),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: DropdownButton(
//                         hint: const Text("نوع المقرر "),
//                         isExpanded: true,
//                         value: typeValue,
//                         items: fileType.map((type) {
//                           return DropdownMenuItem(
//                             value: type,
//                             child: Text(type),
//                           );
//                         }).toList(),
//                         onChanged: (newValue) {
//                           setState(() {
//                             typeValue = newValue as String?;
//                           });
//                         },
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text("تاريخ التسليم:"),
//                           Text(
//                             selectedDate != null
//                                 ? DateFormat('yyyy-MM-dd').format(selectedDate!)
//                                 : "لم يتم التحديد",
//                           ),
//                           ElevatedButton(
//                             onPressed: () => _selectDate(context),
//                             child: const Text("اختر التاريخ"),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                   ],
//                 ),
//               ),
//               const Text(
//                 "تنويه :\nسيتم ارسال هذا المقرر الى الطلاب ",
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 20),
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     InkWell(
//                       child: Container(
//                         width: 100,
//                         height: 50,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8),
//                           color: Colors.amber,
//                         ),
//                         child: const Center(child: Text("رفع")),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sprint1/color_.dart';
import 'package:sprint1/data/dataSourse/staticList.dart';
import 'SendHomeworksController.dart';

class SendHomeworks extends StatefulWidget {
  const SendHomeworks({super.key});

  @override
  State<SendHomeworks> createState() => _SendHomeworksState();
}

class _SendHomeworksState extends State<SendHomeworks> {
  final HomeworkController controller = Get.put(HomeworkController());

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        controller.selectedDate.value = DateFormat('yyyy-MM-dd HH:mm:ss').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:color_.green,
        title: const Text(
          'تحديد مقرر دراسي ',
          style: TextStyle(
            fontSize: 20,
            color: color_.white
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Image.asset(
              'assets/homeworks.png',
              height: 80,
            ),
          ),
        ],
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,color: color_.white,),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromRGBO(227, 227, 227, 1.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Text("يرجى إدخال المعلومات المطلوبة:"),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Obx(() {
                        return DropdownButton<int>(
                          hint: const Text("اختر الصف"),
                          isExpanded: true,
                          value: controller.selectedClassroomId.value == 0
                              ? null
                              : controller.selectedClassroomId.value,
                          items: controller.classrooms.map((classroom) {
                            return DropdownMenuItem<int>(
                              value: classroom.id,
                              child: Text(classroom.name),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            controller.selectedClassroomId.value = newValue!;
                            controller.fetchSubjects(newValue);
                          },
                        );
                      }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Obx(() {
                        return DropdownButton<int>(
                          hint: const Text("اختر المادة"),
                          isExpanded: true,
                          value: controller.selectedSubjectId.value == 0
                              ? null
                              : controller.selectedSubjectId.value,
                          items: controller.subjects.map((subject) {
                            return DropdownMenuItem<int>(
                              value: subject.id,
                              child: Text(subject.name),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            controller.selectedSubjectId.value = newValue!;
                          },
                        );
                      }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Obx(() {
                        return DropdownButton<String>(
                          hint: const Text("نوع المقرر "),
                          isExpanded: true,
                          value: controller.typeValue.value.isEmpty
                              ? null
                              : controller.typeValue.value,
                          items: type.map((type) {
                            return DropdownMenuItem<String>(
                              value: type,
                              child: Text(type),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            if (newValue != null) {
                              controller.typeValue.value = newValue;
                            }
                          },
                        );
                      }
                      ),

                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: const InputDecoration(labelText: "ملاحظات"),
                        onChanged: (value) {
                          controller.notes.value = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: const InputDecoration(labelText: "اسم الواجب"),
                        onChanged: (value) {
                          controller.homeworkName.value = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("تاريخ التسليم:"),
                          Text(
                            controller.selectedDate.value.isNotEmpty
                                ? controller.selectedDate.value
                                : "لم يتم التحديد",
                          ),
                          ElevatedButton(
                            onPressed: () => _selectDate(context),
                            child: const Text("اختر التاريخ"),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              const Text(
                "تنويه :\nسيتم ارسال هذا المقرر الى الطلاب ",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: controller.sendHomework,
                      child: Container(
                        width: 100,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: color_.yellow,
                        ),
                        child: const Center(child: Text("رفع")),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
