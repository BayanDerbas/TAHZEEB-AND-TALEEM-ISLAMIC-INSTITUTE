import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sprint1/color_.dart';
import 'package:sprint1/login/loginController.dart';

import 'StudentConsultShowController.dart';




class StudentShowConsult_screen extends StatefulWidget {
  const StudentShowConsult_screen({super.key});

  @override
  State<StudentShowConsult_screen> createState() => _ConsultAnswerScreenState();
}

class _ConsultAnswerScreenState extends State<StudentShowConsult_screen> {
  final LoginnnnnController _loginController = Get.put(LoginnnnnController());
  final StudentConsultShowController _showController = Get.put(StudentConsultShowController());

  bool _messageSent = false;
  int? consultId;
  int? answered;
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
    // استقبال القيم المرسلة كخريطة (Map)
    final Map<String, dynamic> arguments = Get.arguments;

    // استخراج id و answered من الخريطة
    consultId = arguments['id'] as int?;
    answered = int.tryParse(arguments['answered'].toString());

    if (consultId != null) {
      // جلب بيانات الاستشارة بناءً على id
      _showController.fetchConsultationById(consultId!);
    }
    if(answered==0){
      _messageSent=false;
    }else{
      _messageSent=true;
      // Fetch the reply for the specific consultation
      _showController.StudentfetchReplyByConsultId(consultId!);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // AppBar Section
            SizedBox(
              height: 200,
              child: AppBar(
                title: Obx(() {
                  if (_showController.consultations.isNotEmpty) {
                    return Text(
                    _userName,
                      style: const TextStyle(color: color_.white),
                    );
                  }
                  return const Text("اسم الطالب", style: TextStyle(color: color_.white));
                }),
                backgroundColor: color_.green,
                leading: IconButton(
                  onPressed: () {
                    Get.toNamed('/profileStudent');
                  },
                  icon: const Icon(Icons.account_circle, size: 35, color: Colors.white),
                ),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.notifications, color: Colors.white, size: 30),
                  ),
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.arrow_forward, color: color_.white),
                  ),
                ],
              ),
            ),
            // Main Content Section
            Padding(
              padding: const EdgeInsets.only(top: 125, bottom: 140, left: 10, right: 10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      spreadRadius: 1,
                      blurRadius: 8,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: SizedBox(
                  height: 600,
                  width: 500,
                  child: Card(
                    elevation: 0,
                    margin: const EdgeInsets.fromLTRB(12, 0.1, 12, 0.1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    color: color_.white,
                    child: Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    alignment: Alignment.topRight,
                                    child: const Icon(
                                      Icons.account_circle,
                                      color: color_.yellow,
                                      size: 50,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 1, right: 35, top: 3),
                                    child: Container(
                                      alignment: Alignment.bottomRight,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20),
                                          bottomLeft: Radius.circular(20),
                                        ),
                                        border: Border.all(color: color_.yellow, width: 3),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Obx(() {
                                          if (_showController.consultations.isNotEmpty) {
                                            return Text(
                                              _showController.consultations.last.consult,
                                              style: const TextStyle(color: color_.gray),
                                            );
                                          }
                                          return const Text(
                                            "لم يتم العثور على استشارة",
                                            style: TextStyle(color: color_.gray),
                                          );
                                        }),
                                      ),
                                    ),
                                  ),
                                  if (_messageSent) ...[
                                    Padding(
                                      padding: const EdgeInsets.only(left: 35, right: 1, top: 53),
                                      child: Column(
                                        children: [
                                          Container(
                                            alignment: Alignment.bottomLeft,
                                            decoration: BoxDecoration(
                                              borderRadius: const BorderRadius.only(
                                                topRight: Radius.circular(20),
                                                bottomRight: Radius.circular(20),
                                                topLeft: Radius.circular(20),
                                              ),
                                              border: Border.all(color: color_.green, width: 3),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(16.0),
                                              child:Obx(() {
                                                return Text(
                                                  _showController.message.value,
                                                  style: const TextStyle(color: color_.gray),
                                                );
                                              })
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.bottomLeft,
                                      child: const Icon(
                                        Icons.account_circle,
                                        color: color_.green,
                                        size: 50,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
