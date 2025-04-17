import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:get/get.dart';
import 'package:sprint1/StudentApp/activity/widgets/question_card.dart';
import 'activity_controller.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  final ActivityController activityController = Get.put(ActivityController());

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('التسلية والنشاطات'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button
          },
        ),
      ),
      body: Obx(
            () {
          if (activityController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (activityController.isFinished.value) {
            return SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: (MediaQuery.of(context).size.width / 3) * 2,
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: const Offset(0, 1), // changes position of shadow
                          ),
                        ]),
                    child: Text(
                      activityController.isPass.value
                          ? "تهانينا لقد نجحت"
                          : "الجواب خاطئ",
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 25),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  InkWell(
                    onTap: () {
                      activityController.isPass(false);
                      activityController.answer(0);
                      activityController.isFinished(false);
                      activityController.isStudentStarted(false);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: const Color(0xFFfdc741),
                          borderRadius: BorderRadius.circular(20)),
                      child: const Text(
                        'اعادة النشاط',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                  )
                ],
              ),
            );
          }
          if (activityController.error.value) {
            return const Center(
              child: Text("لا يوجد نشاط حاليا"),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    width: (MediaQuery.of(context).size.width / 3) * 2,
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: const Offset(0, 1), // changes position of shadow
                          ),
                        ]),
                    child: Column(
                      children: [
                        if (activityController.isStarted.value &&
                            !activityController.isStudentStarted.value)
                          const Text(
                            'متاح الآن',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20),
                          ),
                        if (!activityController.isStarted.value &&
                            !activityController.isStudentStarted.value)
                          const Text(
                            'سيبدأ الاختبار بعد',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20),
                          ),
                        if (!activityController.isStarted.value)
                          CountdownTimer(
                            endTime: activityController.endTime.value,
                            onEnd: () {
                              activityController.isStarted(true);
                            },
                          ),
                        if (activityController.isStudentStarted.value)
                          CountdownTimer(
                            endTime: DateTime.now().millisecondsSinceEpoch +
                                activityController.activity.value.duration!,
                            onEnd: () {
                              activityController.compareAnswer();
                            },
                          )
                      ],
                    ),
                  ),
                  if (!activityController.isStudentStarted.value)
                    ElevatedButton(
                      onPressed: activityController.isStarted.value
                          ? () {
                        activityController.isStudentStarted(true);
                      }
                          : null,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFfdc741),
                          disabledBackgroundColor: Colors.black,
                          disabledForegroundColor: Colors.grey.shade500,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 5),
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.zero,
                                  topRight: Radius.zero,
                                  bottomRight: Radius.circular(15),
                                  bottomLeft: Radius.circular(15)))),
                      child: const Text(
                        'ابدأ',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            'اختر الإجابة الصحيحة',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              child: Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: <Widget>[
                                      QuestionCard(
                                        show: activityController
                                            .isStudentStarted.value,
                                        question: activityController
                                            .activity.value.question!,
                                        options: [
                                          activityController
                                              .activity.value.answer1!,
                                          activityController
                                              .activity.value.answer2!,
                                          activityController
                                              .activity.value.answer3!,
                                          activityController
                                              .activity.value.answer4!,
                                        ],
                                      ),
                                      activityController.isStudentStarted.value
                                          ? InkWell(
                                        onTap: () {
                                          activityController
                                              .compareAnswer();
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(16),
                                          decoration: BoxDecoration(
                                              color: const Color(0xFFfdc741),
                                              borderRadius:
                                              BorderRadius.circular(
                                                  20)),
                                          child: const Text(
                                            'ارسل',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight:
                                                FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                        ),
                                      )
                                          : const SizedBox()
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
