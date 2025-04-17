import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sprint1/color_.dart';

import 'first_and_ranks_controller.dart';
import 'widgets/firsts_and_ranks_gray_box_group.dart';

class FirstsAndRanksScreen extends StatefulWidget {
  const FirstsAndRanksScreen({super.key});

  @override
  State<FirstsAndRanksScreen> createState() => _FirstsAndRanksScreenState();
}

class _FirstsAndRanksScreenState extends State<FirstsAndRanksScreen> {
  final FirstsAndRanksController firstsAndRanksController =
      Get.put(FirstsAndRanksController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("الأوائل والمراتب",style: TextStyle(color: color_.white),),
        centerTitle: true,
        backgroundColor: color_.green,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: () {
            Get.back();
            // يمكنك إضافة الوظيفة التي ترغب بها عند الضغط على السهم هنا
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: Obx(() {
        if (firstsAndRanksController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Center(
          child: ListView(
            padding: const EdgeInsets.all(15),
            children: [
              FirstsAndRanksGrayBoxGroup(
                  title: "لوحة الشرف",
                  list: firstsAndRanksController.firstsAndRanksList
                      .getRange(
                          0,
                          min(
                              3,
                              firstsAndRanksController
                                  .firstsAndRanksList.length))
                      .toList()),
              const SizedBox(height: 20),
              FirstsAndRanksGrayBoxGroup(
                  title: "ترتيب الصف",
                  list: firstsAndRanksController.firstsAndRanksList)
            ],
          ),
        );
      }),
    );
  }
}
