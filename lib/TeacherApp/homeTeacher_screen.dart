import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sprint1/login/loginController.dart';

import '../color_.dart';
import 'NextLesson/NextLessonController.dart';

class homeTeacher_screen extends StatefulWidget {
  const homeTeacher_screen({super.key});

  @override
  State<homeTeacher_screen> createState() => _homeTeacher_screenState();
}

class _homeTeacher_screenState extends State<homeTeacher_screen> {
  final LoginnnnnController loginController=  Get.put(LoginnnnnController());
  final LessonController lessonController = Get.put(LessonController());


  String _userName = 'Loading...';

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userData = prefs.getString('user_data');

    if (userData != null) {
      // تحويل سلسلة JSON إلى خريطة
      Map<String, dynamic> userMap = jsonDecode(userData);

      // استخراج اسم المستخدم من الخريطة
      setState(() {
        _userName = userMap['user']['first_name'] +" "+userMap['user']['last_name'];
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
      body: Stack(
        children: [
          SizedBox(
            height: 200,
            child: AppBar(
              title: Text(
                _userName,
                style: const TextStyle(color: color_.white),
              ),
              backgroundColor: color_.green,
              leading: const Icon(Icons.account_circle, size: 35, color: Colors.white),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications, color: Colors.white, size: 30),
                ),
                IconButton(
                  onPressed: () {
                    loginController.logout().then((_) {
                      Get.offNamed('/login');
                    });
                  },
                  icon: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(3.14159), // This rotates the icon by 180 degrees along the Y axis (pi radians)
                    child: const Icon(Icons.logout, color: Colors.white, size: 30),
                  ),
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
                    offset: const Offset(0, 8), // Changes position of shadow to bottom only
                  ),
                ],
              ),
              child: SizedBox(
                height: 400, // Set the desired height for the Card
                child: Card(
                  elevation: 0, // Set card elevation to 0 to use custom shadow
                  margin: const EdgeInsets.fromLTRB(12, 0.1, 12, 0.1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  color: color_.white,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Container(
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: color_.yellow,
                            ),
                            child: Obx((){
                              if (lessonController.isLoading.value) {
                                return Center(child: CircularProgressIndicator());
                              } else if (lessonController.errorMessage.isNotEmpty) {
                                return Center(child: Text(lessonController.errorMessage.value));
                              } else{
                                 return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(height: 5,),
                                    Center(
                                      child: Text(
                                        'الحصة التالية',
                                        style: TextStyle(
                                          color: color_.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "المادة :  التاريخ",
                                      style: TextStyle(
                                        color: color_.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "الصف :  السابع ",
                                      style: TextStyle(
                                        color: color_.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "الشعبة :  الاولى",
                                      style: TextStyle(
                                        color: color_.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                );

                              }
                            },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 22.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed("/QRCodePage");
                                },
                                child: Container(
                                  height: 120,
                                  width: 130,
                                  decoration: BoxDecoration(
                                    // color: Colors.grey.shade100,
                                    border: Border.all(color: color_.green, width: 2.5),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset("assets/QR.png", height: 65),
                                      const Text("تسجيل حضورك", textAlign: TextAlign.center),
                                    ],
                                  ),
                                ),
                              ),
                              //const SizedBox(width: 20,),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed("/LibraryTeacher");
                                },
                                child: Container(
                                  height: 120,
                                  width: 130,
                                  decoration: BoxDecoration(

                                    border: Border.all(color: color_.green, width: 2.5),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset("assets/8.png", height: 65),
                                      const Text("المكتبة", textAlign: TextAlign.center),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(bottom: 260, left: 25, right: 25),
              height: 50, // Adjust the height as needed
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    spreadRadius: 1,
                    blurRadius: 8,
                    offset: const Offset(0, 8), // Changes position of shadow to bottom only
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: color_.gray),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 30,),
                  IconButton(onPressed: (){Get.toNamed("/UploadFile");}, icon: Image.asset("assets/21.png", height: 40, color: color_.yellow,),),
                  const SizedBox(width: 20,),
                  const VerticalDivider(
                    color: color_.gray,
                    thickness: 2,
                    width: 20,
                    indent: 5,
                    endIndent: 5,
                  ),
                  const SizedBox(width: 40,),
                  IconButton(onPressed: (){Get.toNamed("/TeacherQuestionScreen");}, icon: const Icon(Icons.contact_support_outlined, color: color_.yellow, size: 30,)),
                  const SizedBox(width: 40,),
                  const VerticalDivider(
                    color: color_.gray,
                    thickness: 2,
                    width: 20,
                    indent: 5,
                    endIndent: 5,
                  ),
                  const SizedBox(width: 17,),
                  IconButton(onPressed: (){Get.toNamed("/SendHomeworks");}, icon: const Icon(Icons.edit, color: color_.yellow, size: 30,)),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(bottom: 10, left: 12, right: 19),
              child: Row(
                children: [
                  IconButton(onPressed: (){Get.toNamed("/PlansTeacher");}, icon: Image.asset("assets/17.png", height: 60,)),
                  const Spacer(),
                  IconButton(onPressed: (){Get.toNamed("/TeacherWeektableScreen");}, icon: Image.asset("assets/18.png", height: 57,)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
