import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sprint1/AdviserApp/ConsultResponse/ConsultResponseController.dart';
import 'package:sprint1/AdviserApp/ConsultResponse/ConsultShowController.dart';
import 'package:sprint1/color_.dart';
import 'package:sprint1/login/loginController.dart';


class consultAnswer_screen extends StatefulWidget {
  const consultAnswer_screen({super.key});

  @override
  State<consultAnswer_screen> createState() => _ConsultAnswerScreenState();
}

class _ConsultAnswerScreenState extends State<consultAnswer_screen> {
  final LoginnnnnController _loginController = Get.put(LoginnnnnController());
  final ConsultShowController _showController = Get.put(ConsultShowController());
  final ConsultReplyController _replyController = Get.put(ConsultReplyController());

  bool _messageSent = false;
  int? consultId;
  int? answered;

  @override
  void initState() {
    super.initState();
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
      _replyController.fetchReplyByConsultId(consultId!);
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
                  // عرض اسم الطالب من البيانات
                  if (_showController.consultations.isNotEmpty) {
                    return Text(
                      _showController.consultations.last.studentName,
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
                                  // Placeholder for existing message or placeholder
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
                                              child: Obx(() {
                                                return Text(
                                                  _replyController.message.value,
                                                  style: const TextStyle(color: color_.gray),
                                                );
                                              }),
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
                        if (!_messageSent)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 1.0),
                            child: Container(
                              width: 500,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(25),
                                  bottomLeft: Radius.circular(25),
                                ),
                                color: color_.green,
                              ),
                              child: TextField(
                                controller: _replyController.textController,
                                maxLines: 2,
                                style: const TextStyle(color: color_.white),
                                decoration: const InputDecoration(
                                  hintText: "  اكتب هنا",
                                  hintStyle: TextStyle(color: color_.white),
                                  border: InputBorder.none,
                                ),
                                onChanged: (value) {
                                  _replyController.message.value = value;
                                },
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (!_messageSent)
              Positioned(
                left: 22,
                right: 240,
                bottom: 70,
                child: ElevatedButton(
                  onPressed: () async {
                    await _replyController.sendMessage(
                      _showController.consultations.first.id,
                      _replyController.message.value,
                    );

                    // Notify that the message was sent and the consultation should now be considered answered
                    setState(() {
                      _messageSent = true;
                    });

                    // Fetch the latest reply immediately to update the UI
                    await _replyController.fetchReplyByConsultId(consultId!);
                    // Add a delay before navigating back
                    await Future.delayed(Duration(seconds: 2)); // Adjust the duration as needed

                    // Notify the previous screen to refresh its data
                    Get.back(result: true);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color_.yellow,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                  child: const Text(
                    'الرد',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
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
