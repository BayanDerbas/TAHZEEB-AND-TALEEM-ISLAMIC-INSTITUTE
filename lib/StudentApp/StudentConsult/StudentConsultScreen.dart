import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sprint1/StudentApp/StudentConsult/StudentConsultController.dart';
import 'package:sprint1/login/loginController.dart';

import '../../color_.dart';

class StudentConsultScreen extends StatefulWidget {
  const StudentConsultScreen({super.key});

  @override
  State<StudentConsultScreen> createState() => _StudentConsultScreenState();
}

class _StudentConsultScreenState extends State<StudentConsultScreen> {
  List<String> itemTitle = ["تم الرد", "لم يرد عليها"];
  int selectedIndex = 0;

  final StudentConsultController controller = Get.put(StudentConsultController());
  final LoginnnnnController _loginController = Get.put(LoginnnnnController());

  @override
  void initState() {
    super.initState();
    // Refresh data when the widget is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchQuestions(); // Refresh data here
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
            Get.back();
            },
            icon: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(3.14159),
              child: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
            ),
          ),
          // IconButton(
          //   onPressed: () {
          //     Get.back();
          //   },
          //   icon: const Icon(Icons.arrow_forward, color: color_.white),
          // ),
        ],
        leading: IconButton(onPressed: (){Get.toNamed("/sendConsult_screen");}, icon: Icon(Icons.quiz, color: color_.white),),
        title: const Text(
          "استشاراتي ",
          style: TextStyle(color: color_.white),
        ),
        centerTitle: true,
        backgroundColor: color_.green,
      ),
      backgroundColor: Colors.white,

      body: Obx(() {
        // Update the list based on the selected index
        var questions = selectedIndex == 0
            ? controller.answeredQuestions
            : controller.unansweredQuestions;

        return Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(15),
                children: [
                  Container(
                    height: 630,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            height: 595,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: const Border(
                                right: BorderSide(width: 18, color: color_.yellow),
                              ),
                              borderRadius: const BorderRadius.all(Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(1, 4),
                                ),
                              ],
                            ),
                            child: ListView.separated(
                              shrinkWrap: true,
                              itemCount: questions.length,
                              itemBuilder: (BuildContext context, int index) {
                                var question = questions.reversed.toList(); // Reverse the list
                                return ListTile(
                                  contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                                  title: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Text("الاستشارة ${index + 1}",
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(width: 5),
                                          const Icon(
                                            Icons.person_2_rounded,
                                            color: color_.yellow,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  leading: Column(
                                    children: [
                                      Text(question[index].updatedAt.toString()),
                                      Text(question[index].createdAt.toString()),
                                    ],
                                  ),
                                  subtitle: Wrap(  alignment: WrapAlignment.end,
                                    children:[
                                      Text(
                                        question[index].consult,
                                        maxLines: 1,
                                        softWrap: true,  // يجعل النص يلتف إلى الأسطر الجديدة بدلاً من تجاوز العرض
                                      ),
                                    ],
                                  ),
                                  onTap: () async {
                                    var result = await Get.toNamed(
                                      '/StudentShowConsult_screen',
                                      arguments: {
                                        'id': question[index].id,
                                        'answered': question[index].answered,
                                      },
                                    );

                                    if (result == true) {
                                      // Refresh data when navigating back with result true
                                      controller.fetchQuestions(); // Replace with actual method to refresh data
                                    }
                                  },

                                );
                              },
                              separatorBuilder: (BuildContext context, int index) {
                                return const Divider(
                                  color: Colors.black45,
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Wrap(
                spacing: 10,
                children: List<Widget>.generate(
                  itemTitle.length,
                      (index) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedIndex == index
                            ? color_.yellow
                            : Colors.white,
                        foregroundColor: Colors.black,
                        side: const BorderSide(color: color_.yellow, width: 3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(500),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
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
            ),
          ],
        );
      }),
    );
  }
}
