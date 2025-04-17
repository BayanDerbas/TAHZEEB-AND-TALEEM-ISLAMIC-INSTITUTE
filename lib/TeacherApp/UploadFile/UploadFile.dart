//
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../data/dataSourse/staticList.dart';
// import 'UploadFileController.dart';
//
// class UploadFile extends StatefulWidget {
//   const UploadFile({super.key});
//
//   @override
//   State<UploadFile> createState() => _UploadFileState();
// }
//
// class _UploadFileState extends State<UploadFile> {
//   final DataController controller = Get.put(DataController());
//   String? fileName;
//
//   Future<void> _pickFile() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles();
//
//     if (result != null) {
//       PlatformFile file = result.files.first;
//       setState(() {
//         fileName = file.name;
//       });
//       print('File Name: ${file.name}');
//       print('File Size: ${file.size}');
//       print('File Extension: ${file.extension}');
//       print('File Path: ${file.path}');
//       // يمكنك هنا استخدام معلومات الملف كما تريد
//     } else {
//       // المستخدم قام بإلغاء اختيار الملف
//     }
//   }
//
//   void _onMoreVertPressed() {
//     _pickFile();
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
//               'رفع كتاب',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(width: 110),
//             Container(
//               margin: const EdgeInsets.symmetric(vertical: 10),
//               child: Image.asset(
//                 'assets/uplaod.png',
//                 height: 40,
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
//                         return DropdownButton<int>(
//                           hint: const Text("اختر الصف"),
//                           isExpanded: true,
//                           value: controller.selectedClassroomId.value == 0
//                               ? null
//                               : controller.selectedClassroomId.value,
//                           items: controller.classrooms.map((classroom) {
//                             return DropdownMenuItem<int>(
//                               value: classroom.id,
//                               child: Text(classroom.name),
//                             );
//                           }).toList(),
//                           onChanged: (newValue) {
//                             controller.selectedClassroomId.value = newValue!;
//                             controller.fetchSubjects(newValue);
//                           },
//                         );
//                       }),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Obx(() {
//                         return DropdownButton<int>(
//                           hint: const Text("اختر المادة"),
//                           isExpanded: true,
//                           value: controller.selectedSubjectId.value == 0
//                               ? null
//                               : controller.selectedSubjectId.value,
//                           items: controller.subjects.map((subject) {
//                             return DropdownMenuItem<int>(
//                               value: subject.id,
//                               child: Text(subject.name),
//                             );
//                           }).toList(),
//                           onChanged: (newValue) {
//                             controller.selectedSubjectId.value = newValue!;
//                           },
//                         );
//                       }),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Obx(() {
//                         return DropdownButton<String>(
//                           hint: const Text("نوع الملف "),
//                           isExpanded: true,
//                           value: controller.typeValue.value.isEmpty
//                               ? null
//                               : controller.typeValue.value,
//                           items: fileType.map((type) {
//                             return DropdownMenuItem<String>(
//                               value: type,
//                               child: Text(type),
//                             );
//                           }).toList(),
//                           onChanged: (newValue) {
//                             if (newValue != null) {
//                               controller.typeValue.value = newValue;
//                             }
//                           },
//                         );
//                       }),
//                     ),
//                     const SizedBox(height: 10),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Column(
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Expanded(
//                                 child: Text(
//                                   fileName ?? "اختر الملف",
//                                   style: const TextStyle(color: Colors.black54),
//                                   overflow: TextOverflow.ellipsis,
//                                   softWrap: false,
//                                 ),
//                               ),
//                               IconButton(
//                                 icon: const Icon(Icons.more_vert_outlined),
//                                 color: Colors.black54,
//                                 onPressed: _onMoreVertPressed,
//                               ),
//                             ],
//                           ),
//                           const Divider(),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                       child: TextFormField(
//                         cursorColor: const Color.fromRGBO(29, 122, 67, 1),
//                         decoration: const InputDecoration(
//                           labelText: "اسم الملف",
//                           floatingLabelStyle: TextStyle(
//                             color: Color.fromRGBO(29, 122, 67, 1),
//                           ),
//                           focusColor: Color.fromRGBO(29, 122, 67, 1),
//                           focusedBorder: UnderlineInputBorder(
//                             borderSide: BorderSide(
//                               color: Color.fromRGBO(29, 122, 67, 1),
//                             ),
//                           ),
//                           enabledBorder: UnderlineInputBorder(
//                             borderSide: BorderSide(
//                               color: Colors.grey,
//                             ),
//                           ),
//                         ),
//                         onChanged: (value) {
//                           setState(() {});
//                         },
//                         validator: (value) {
//                           return null;
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const Text(
//                 "تنويه :\nسيتم مراجعة الملف من قبل الادارة وفي \nحال الموافقة سيتم رفعه الى المكتبة",
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 20),
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     InkWell(
//                       onTap: () {
//                         // يمكنك إضافة الوظيفة التي ترغب بها عند الضغط على الزر هنا
//                       },
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
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sprint1/color_.dart';
import 'package:sprint1/data/dataSourse/staticList.dart';
import 'UploadFileController.dart';

class UploadFile extends StatefulWidget {
  const UploadFile({super.key});

  @override
  State<UploadFile> createState() => _UploadFileState();
}

class _UploadFileState extends State<UploadFile> {
  final DataController controller = Get.put(DataController());
  final TextEditingController titleController = TextEditingController();

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile file = result.files.first;
      controller.fileName.value = file.path ?? '';
      print('File Name: ${file.name}');
      print('File Size: ${file.size}');
      print('File Extension: ${file.extension}');
      print('File Path: ${file.path}');
    } else {
      // User canceled the picker
    }
  }

  void _onMoreVertPressed() {
    _pickFile();
  }

  void _uploadFile() {
    if (controller.fileName.value.isNotEmpty && titleController.text.isNotEmpty) {
      controller.uploadFile(titleController.text);
    } else {
      // Handle error (show message to user)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color_.green,
        title: const Text(
          'رفع كتاب',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color_.white
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Image.asset(
              'assets/uplaod.png',
              height: 40,
            ),
          ),
        ],
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,color: color_.white,),
          onPressed: () {
            Get.back();

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
                          hint: const Text("نوع الملف "),
                          isExpanded: true,
                          value: controller.typeValue.value.isEmpty
                              ? null
                              : controller.typeValue.value,
                          items: fileType.map((type) {
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
                      }),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Obx(() {
                                  return Text(
                                    controller.fileName.value.isEmpty ? "اختر الملف" : controller.fileName.value.split('/').last,
                                    style: const TextStyle(color: Colors.black54),
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                  );
                                }),
                              ),
                              IconButton(
                                icon: const Icon(Icons.more_vert_outlined),
                                color: Colors.black54,
                                onPressed: _onMoreVertPressed,
                              ),
                            ],
                          ),
                          const Divider(),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextFormField(
                        controller: titleController,
                        cursorColor: const Color.fromRGBO(29, 122, 67, 1),
                        decoration: const InputDecoration(
                          labelText: "اسم الملف",
                          floatingLabelStyle: TextStyle(
                            color: Color.fromRGBO(29, 122, 67, 1),
                          ),
                          focusColor: Color.fromRGBO(29, 122, 67, 1),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(29, 122, 67, 1),
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {});
                        },
                        validator: (value) {
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const Text(
                "تنويه :\nسيتم مراجعة الملف من قبل الادارة وفي \nحال الموافقة سيتم رفعه الى المكتبة",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: _uploadFile,
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
