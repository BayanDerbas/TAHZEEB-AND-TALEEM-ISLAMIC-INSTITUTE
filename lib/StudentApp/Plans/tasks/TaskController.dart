import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class TasksController extends GetxController {
  RxList<Map<dynamic, dynamic>> tasks = <Map<dynamic, dynamic>>[].obs;
  RxString taskTitle = ''.obs;
  final int? index;

  TasksController({this.index});

  @override
  void onInit() {
    super.onInit();
    if (index != null) {
      _loadTasks(index!);
    }
  }

  Future<void> _loadTasks(int index) async {
    try {
      final box = await Hive.openBox('taskBox');
      final taskData = box.getAt(index);
      print('Loading tasks at index $index: $taskData'); // Debugging

      if (taskData != null) {
        if (taskData is Map) {
          final Map<String, dynamic> taskDataMap = Map<String, dynamic>.from(taskData);

          print('Loaded taskData: ${taskDataMap.toString()}'); // Debugging

          tasks.value = List<Map<String, dynamic>>.from(taskDataMap['tasks'] ?? []);
          taskTitle.value = taskDataMap['title'];
          print('Tasks after setState: ${tasks.value}'); // Debugging
        } else {
          print('Expected a Map but got ${taskData.runtimeType}'); // Debugging
          tasks.value = [];
          taskTitle.value = '';
        }
      } else {
        print('No task data found at index $index'); // Debugging
        tasks.value = [];
        taskTitle.value = '';
      }
    } catch (e) {
      print('Error loading tasks: $e'); // Debugging
    }
  }

  Future<void> save() async {
    try {
      final box = await Hive.openBox('taskBox');
      if (taskTitle.value.isNotEmpty && tasks.isNotEmpty) {
        final taskData = {
          'title': taskTitle.value,
          'tasks': tasks,
        };
        if (index != null) {
          await box.putAt(index!, taskData);
          print('Updated tasks at index ${index!} with data: $taskData'); // Debugging
        } else {
          await box.add(taskData);
          print('Added new tasks with data: $taskData'); // Debugging
        }
        Get.snackbar('Success', 'تم حفظ المهام بنجاح!');
      } else {
        Get.snackbar('Error', 'الرجاء إدخال عنوان للمهام وإضافة مهام.');
      }
    } catch (e) {
      print('Error saving tasks: $e'); // Debugging
    }
  }

  Future<void> getTitleFromUser() async {
    final TextEditingController titleController = TextEditingController();
    await Get.dialog(
      AlertDialog(
        title: const Text('أدخل العنوان'),
        content: TextField(
          controller: titleController,
          decoration: const InputDecoration(hintText: 'أدخل عنواناً للمهام'),
        ),
        actions: [
          TextButton(
            child: const Text('إلغاء'),
            onPressed: () {
              Get.back();
            },
          ),
          TextButton(
            child: const Text('حفظ'),
            onPressed: () {
              taskTitle.value = titleController.text;
              Get.back();
            },
          ),
        ],
      ),
    );
  }

  void addTask(String taskName) {
    tasks.add({'name': taskName, 'isChecked': false});
    print('Added new task: $taskName'); // Debugging
  }
}
