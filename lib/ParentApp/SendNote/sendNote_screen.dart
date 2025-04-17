import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../color_.dart';
import 'SendNoteController.dart';

class SendNoteScreen extends StatefulWidget {
  const SendNoteScreen({super.key});

  @override
  State<SendNoteScreen> createState() => _SendNoteScreenState();
}

class _SendNoteScreenState extends State<SendNoteScreen> {
  final NoteController noteController = Get.put(NoteController());
  final TextEditingController sendController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
    sendController.addListener(() {
      noteController.noteText.value = sendController.text;
    });
  }
  String _userName = 'Loading...';

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userData = prefs.getString('user_data');

    if (userData != null) {
      Map<String, dynamic> userMap = jsonDecode(userData);
      setState(() {
        _userName = userMap['user']['student_name'];
      });
    } else {
      print("لم يتم العثور على بيانات المستخدم.");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            SizedBox(
              height: 200,
              child: AppBar(
                title: Text(
                  _userName,
                  style: const TextStyle(color: color_.white),
                ),
                backgroundColor: color_.green,
                leading: IconButton(
                  onPressed: () {
                  //  Get.toNamed('/profileStudent');
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
                    icon: const Icon(Icons.arrow_forward, color: Colors.white, size: 30),
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
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: SizedBox(
                  height: 550,
                  child: Card(
                    elevation: 0,
                    margin: const EdgeInsets.fromLTRB(12, 0.1, 12, 0.1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    color: color_.white,
                    child: Column(
                      children: [
                        const SizedBox(height: 25),
                        const Center(
                          child: Text(
                            "ملاحظة",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
                          child: Container(
                            height: 400,
                            padding: const EdgeInsets.all(25),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: color_.green, width: 3),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextField(
                                  controller: sendController,
                                  maxLines: 11,
                                  decoration: const InputDecoration(
                                    hintText: 'اكتب هنا...\n\nيرجى أن تتضمن الرسالة على كلام لائق وذات قيمة',
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
              bottom: 60,
              child: Obx(() => ElevatedButton(
                onPressed: noteController.isLoading.value ? null : () {
                  noteController.sendNote();
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
              )),
            ),
          ],
        ),
      ),
    );
  }
}
