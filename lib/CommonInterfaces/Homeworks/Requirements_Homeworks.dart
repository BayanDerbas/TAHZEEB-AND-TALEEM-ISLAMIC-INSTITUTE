// requirement_homeworks.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sprint1/color_.dart';

import 'HomeworksController.dart';
import 'HomeworksModel.dart';

class RequirementHomeworks extends StatelessWidget {
  final HomeworkController controller = Get.put(HomeworkController());

  RequirementHomeworks({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: color_.green,
          title: const Text(
            'المقررات الدراسية',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Image.asset(
                'assets/homeworks.png',
                height: 150,
              ),
            ),
          ],
          centerTitle: true,
          leading: Container(
            child: IconButton(
              icon: const Icon(Icons.arrow_back,color: Colors.white,),
              onPressed: () {
                Get.back();
                // يمكنك إضافة الوظيفة التي ترغب بها عند الضغط على السهم هنا
              },
            ),
          ),
          bottom: const TabBar(
            labelColor: Colors.white,
            indicatorColor: Colors.amber,
            tabs: [
              Tab(
                text: 'دروس ',
              ),
              Tab(
                text: 'تسميع',
              ),
              Tab(
                text: 'واجبات',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else if (controller.homeworks.isEmpty) {
                return const Center(child: Text("No homeworks available"));
              } else {
                var filteredHomeworks = controller.homeworks
                    .where((hw) => hw.type == 'درس مقرر')
                    .toList();
                return _buildHomeworkList(filteredHomeworks);
              }
            }),
            Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else if (controller.homeworks.isEmpty) {
                return const Center(child: Text("No homeworks available"));
              } else {
                var filteredHomeworks = controller.homeworks
                    .where((hw) => hw.type == 'تسميع')
                    .toList();
                return _buildHomeworkList(filteredHomeworks);
              }
            }),
            Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else if (controller.homeworks.isEmpty) {
                return const Center(child: Text("No homeworks available"));
              } else {
                var filteredHomeworks = controller.homeworks
                    .where((hw) => hw.type == 'واجب')
                    .toList();
                return _buildHomeworkList(filteredHomeworks);
              }
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeworkList(List<Homework> homeworks) {
    return ListView.builder(
      itemCount: homeworks.length,
      itemBuilder: (context, index) {
        var homework = homeworks[index];
        return Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(homework.subjectName),
                    Text(homework.date),
                  ],
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(homework.notes),
              ),
            ],
          ),
        );
      },
    );
  }
}
