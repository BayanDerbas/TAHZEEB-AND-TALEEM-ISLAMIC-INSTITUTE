import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sprint1/color_.dart';
import 'package:sprint1/login/loginController.dart';
import '../../StudentApp/Student_question/StudentQuestoinController.dart';
import '../../TeacherApp/SendHomeworks/SubjectModel.dart';
import 'QuestionController.dart';
import 'QuestionModel.dart';
import 'SubjectController.dart';


class sendQuestion_screen extends StatefulWidget {
  const sendQuestion_screen({Key? key}) : super(key: key);

  @override
  State<sendQuestion_screen> createState() => _SendQuestionScreenState();
}

class _SendQuestionScreenState extends State<sendQuestion_screen> {
  final subjectController = Get.put(SubjectController());
  final QuestionController questionController = Get.put(QuestionController());
  Subject? selectedSubject;
  final TextEditingController questionTextController = TextEditingController();
  final LoginnnnnController loginController = Get.put(LoginnnnnController());
  String _userName = 'Loading...';

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userData = prefs.getString('user_data');

    if (userData != null) {
      // تحويل سلسلة JSON إلى خريطة
      Map<String, dynamic> userMap = jsonDecode(userData);

      // استخراج اسم المستخدم من الخريطة
      setState(() {
        _userName = userMap['user']['full_name'];
        print("..........................................................$_userName");
      });

      print("اسم المستخدم: $_userName");
    } else {
      print("لم يتم العثور على بيانات المستخدم.");
    }
  }
  @override
  void initState() {
    super.initState();
    _loadUserData();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 200,
              child: AppBar(
                title: Text(
                  _userName,
                  style: TextStyle(color: color_.white),
                ),
                backgroundColor: color_.green,
                leading: IconButton(
                  onPressed: () {
                    Get.toNamed('/profileStudent');
                  },
                  icon: Icon(Icons.account_circle, size: 35, color: Colors.white),
                ),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.notifications, color: Colors.white, size: 30),
                  ),
                  IconButton(
                    onPressed: () {Get.back();},
                    icon: Icon(Icons.arrow_forward, color: Colors.white, size: 30),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 125, bottom: 175, left: 10, right: 10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      spreadRadius: 1,
                      blurRadius: 8,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: SizedBox(
                  height: 560,
                  child: Card(
                    elevation: 0,
                    margin: EdgeInsets.fromLTRB(12, 0.1, 12, 0.1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    color: color_.white,
                    child: Column(
                      children: [
                        SizedBox(height: 25,),
                        Center(
                          child: Text(
                            "سؤال",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 5,),
                        Container(
                          width: 160,
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: color_.white,
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                spreadRadius: 1,
                                blurRadius: 8,
                                offset: Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.arrow_drop_down,
                                color: color_.yellow,
                                size: 30,
                              ),
                              Expanded(
                                child: Obx(() {
                                  return DropdownButton<Subject>(
                                    underline: SizedBox(),
                                    value: selectedSubject,
                                    hint: selectedSubject == null
                                        ? Text("اختر المادة")
                                        : null,
                                    iconSize: 0,
                                    isExpanded: true,
                                    alignment: Alignment.centerRight,
                                    onChanged: (Subject? newValue) {
                                      setState(() {
                                        selectedSubject = newValue;
                                      });
                                    },
                                    items: subjectController.subjects.map((subject) {
                                      return DropdownMenuItem<Subject>(
                                        value: subject,
                                        child: Text(subject.name),
                                      );
                                    }).toList(),
                                  );
                                }),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20, right: 20, top: 15),
                          child: Container(
                            height: 400,
                            padding: EdgeInsets.all(25),
                            decoration: BoxDecoration(
                              color: color_.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: color_.green, width: 3),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextField(
                                  controller: questionTextController,
                                  maxLines: 11,
                                  cursorColor: color_.green,
                                  decoration: InputDecoration(
                                    hintText: 'اكتب هنا...\n\nيرجى أن يكون السؤال مختصر ومهم و واضح',
                                    border: InputBorder.none,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 22,
              right: 240,
              bottom: 100,
              child: ElevatedButton(
                onPressed: () async {
                  if (selectedSubject != null && questionTextController.text.isNotEmpty) {
                    await questionController.checkTeacherAvailability(selectedSubject!.id);

                    if (questionController.teacherAvailable.value) {
                      final question = QuestionModel(
                        studentId: 1,
                        subjectId: selectedSubject!.id,
                        question: questionTextController.text,
                      );

                      await questionController.sendQuestion(question);

                      if (questionController.questionSent.value) {
                        // تحديث البيانات في الشاشة السابقة
                        await Get.find<StudentQuestionController>().fetchQuestions();
                      }
                      // إفراغ محتوى TextEditingController بعد الإرسال
                      questionTextController.clear();
                    } else {
                      Get.snackbar('تحذير', 'لا يوجد معلم متاح لهذه المادة');
                    }
                  } else {
                    Get.snackbar('تحذير', 'يرجى ملء جميع الحقول');
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: color_.yellow,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                child: const Text(
                  'أرسل',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            )

            // Positioned(
            //   left: 22,
            //   right: 240,
            //   bottom: 100,
            //   child: ElevatedButton(
            //     onPressed: () async {
            //       if (selectedSubject != null && questionTextController.text.isNotEmpty) {
            //         await questionController.checkTeacherAvailability(selectedSubject!.id);
            //
            //         if (questionController.teacherAvailable.value) {
            //           final question = QuestionModel(
            //             studentId: 1,
            //             subjectId: selectedSubject!.id,
            //             question: questionTextController.text,
            //           );
            //
            //           await questionController.sendQuestion(question);
            //
            //           if (questionController.questionSent.value) {
            //             Get.snackbar('نجاح', 'تم إرسال السؤال بنجاح');
            //           } else {
            //             Get.snackbar('فشل', 'فشل في إرسال السؤال');
            //           }
            //         } else {
            //           Get.snackbar('تحذير', 'لا يوجد معلم متاح لهذه المادة');
            //         }
            //       } else {
            //         Get.snackbar('تحذير', 'يرجى ملء جميع الحقول');
            //       }
            //    questionController.sendQuestion().then((_) async {
            //    // إفراغ محتوى TextEditingController بعد الإرسال
            //    questionTextController.clear();
            //    // تحديث البيانات في الشاشة السابقة
            //
            //    await Get.find<StudentQuestionController>().fetchQuestions();
            //     });
            //       },
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: color_.yellow,
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(25),
            //       ),
            //       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            //     ),
            //     child: Text(
            //       'أرسل',
            //       style: TextStyle(
            //         color: Colors.white,
            //         fontSize: 18,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
