import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sprint1/color_.dart';
import 'package:sprint1/login/loginController.dart';
import 'package:sprint1/MentorApp/monitor_home/classes_model.dart';
import 'package:sprint1/MentorApp/monitor_home/monitor_check_students/monitor_check_students.dart';
import 'package:sprint1/MentorApp/monitor_home/monitor_home_controller.dart';

class MonitorHome extends StatefulWidget {
  const MonitorHome({super.key});

  @override
  State<MonitorHome> createState() => _MonitorHomeState();
}

class _MonitorHomeState extends State<MonitorHome> {
  String? selectedClass; // Variable to hold the selected class
  List<String> classes = [
    "Class 1",
    "Class 2",
    "Class 3"
  ]; // Example classes list
  final MonitorHomeController monitorHomeController =
      Get.put(MonitorHomeController());
  final LoginnnnnController loginController = Get.put(LoginnnnnController());

  var _userName="Loading...";


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
      body: Obx(
        () {
      if (monitorHomeController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      } else if (monitorHomeController.classes == null || monitorHomeController.classes.isEmpty) {
        return const Center(child: Text('No classes available'));
      }
          return Stack(
            children: [
              Container(
                height: 200,
                child: AppBar(
                  title: Text(
                    _userName,
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: color_.green,
                  leading: IconButton(
                    onPressed: () {
                      // Get.toNamed('/profileStudent');
                    },
                    icon: Icon(Icons.account_circle,
                        size: 35, color: Colors.white),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.notifications,
                          color: Colors.white, size: 30),
                    ),
                    IconButton(
                      onPressed: () {
                        loginController.logout().then((_) {
                          Get.offNamed('/login');
                        });
                      },
                      icon: Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationY(3.14159),
                        child:
                            Icon(Icons.logout, color: Colors.white, size: 30),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: 125, bottom: 140, left: 10, right: 10),
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
                    height: 600,
                    width: 500,
                    child: Card(
                      elevation: 0,
                      margin: EdgeInsets.fromLTRB(12, 0.1, 12, 0.1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            SizedBox(height: 40),
                            Center(
                              child: Text(
                                "تفقد الحضور الطلاب",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                                height: 20), // Space between text and dropdown
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              margin: EdgeInsets.symmetric(horizontal: 30),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200, // Background color
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 8,
                                    offset: Offset(
                                        0, 4), // Shadow direction: bottom
                                  ),
                                ],
                              ),
                              child: DropdownButton<String>(
                                hint: Text("اختر الصف",
                                    style: TextStyle(
                                        color: Colors.black)), // Hint text
                                value: selectedClass,
                                isExpanded:
                                    true, // Make dropdown expand to full width
                                underline: SizedBox(), // Remove the underline
                                iconEnabledColor:
                                    Colors.black, // Change arrow color here
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedClass = newValue!;
                                  });
                                },
                                items: monitorHomeController.classes.value
                                    .map<DropdownMenuItem<String>>(
                                        (ClassesModel value) {
                                  return DropdownMenuItem<String>(
                                    value: value.id.toString(),
                                    child: Text(value.name!,
                                        style: TextStyle(color: Colors.black)),
                                  );
                                }).toList(),
                              ),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            if (selectedClass != null) // Show container only if a class is selected
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              MonitorCheckStudents(
                                                classroomId:
                                                    int.parse(selectedClass!),
                                              )));
                                },
                                child: Container(
                                  width: 130,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: color_.yellow,
                                  ),
                                  child: Center(
                                    child: Text(
                                      "إجراء التفقد",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            const SizedBox(height: 30),
                            Divider(),
                            const SizedBox(height: 30),
                            const Center(
                              child: Text(
                                "تفقد الحضور المعلمين",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            InkWell(
                                onTap: (){Get.toNamed("/BarcodeScanPage");},
                                child: Image.asset("assets/QR.png", height: 200,width: 200,)),
                            const Center(
                              child: Text(
                                "امسح الباركود عند المعلم",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
