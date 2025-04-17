import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../color_.dart';
import 'ProfilePArentController.dart';

class profileStudent_Parent extends StatefulWidget {
  const profileStudent_Parent({super.key});
  @override
  State<profileStudent_Parent> createState() => _ProfileStudentScreenState();
}

class _ProfileStudentScreenState extends State<profileStudent_Parent> {
  final ProfileParentController studentController = Get.put(ProfileParentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        // Access the 'student' member from the instance
        final student = studentController.student.value;

        return Column(
          children: [
            Align(
              //alignment: Alignment.topRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset("assets/12.png"),
                ],
              ),
            ),
            Image.asset(
              "assets/55.png",
              height: 151,
              color: color_.yellow,
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("الاسم: ${student.name}", style: const TextStyle(fontSize: 20)),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(height: 0.2, color: color_.black, indent: 20, endIndent: 20),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("المرحلة التعليمية: ${student.educationStage}", style: const TextStyle(fontSize: 20)),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(height: 0.2, color: color_.black, indent: 20, endIndent: 20),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("الصف: ${student.classroomName}", style: const TextStyle(fontSize: 20)),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(height: 0.2, color: color_.black, indent: 20, endIndent: 20),
            const SizedBox(height: 70),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 130,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: color_.whitegray,
                      borderRadius: BorderRadius.circular(25.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 10,
                          offset: const Offset(5, 5),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 25),
                        Column(
                          children: [
                            const SizedBox(height: 45),
                            const Text("معدل الطالب"),
                            Text("${studentController.Range.value.finalAverageMark} %"),
                          ],
                        ),
                        const SizedBox(width: 55),
                        Column(
                          children: [
                            const SizedBox(height: 45),
                            const Text("ترتيب الطالب"),
                            Text("${studentController.studentRank}"),
                          ],
                        ),
                        const SizedBox(width: 50),
                         Column(
                          children: [
                            SizedBox(height: 45),
                            Text("نقاط الطالب"),
                            Obx(() {
                              return Text(
                                "${studentController.studentScore.value.toString()}",
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              );
                            }),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: -40,
                    left: 10,
                    child: Container(
                      width: 110,
                      decoration: BoxDecoration(
                        color: color_.yellow,
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: Image.asset(
                        "assets/19.png",
                        height: 90,
                        width: 80,
                        color: color_.white,
                      ),
                    ),
                  ),
                  Positioned(
                    top: -40,
                    left: 131,
                    child: Container(
                      width: 110,
                      decoration: BoxDecoration(
                        color: color_.yellow,
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: Image.asset("assets/9.png", height: 90, width: 80, color: color_.white),
                    ),
                  ),
                  Positioned(
                    top: -40,
                    right: 15,
                    child: Container(
                      width: 110,
                      decoration: BoxDecoration(
                        color: color_.yellow,
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: Image.asset("assets/20.png", height: 90, width: 80, color: color_.white),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 0.01),
                  child: Image.asset("assets/13.png"),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}