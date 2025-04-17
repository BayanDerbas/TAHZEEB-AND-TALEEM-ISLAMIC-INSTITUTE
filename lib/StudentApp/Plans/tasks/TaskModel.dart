import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Task {
  String name;
  bool isChecked;

  Task({required this.name, required this.isChecked});

  // لتحويل الكائن إلى JSON
  Map<String, dynamic> toJson() => {
    'name': name,
    'isChecked': isChecked,
  };

  // لإنشاء كائن من JSON
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      name: json['name'],
      isChecked: json['isChecked'],
    );
  }
}

class TaskList {
  String title;
  List<Task> tasks;

  TaskList({required this.title, required this.tasks});

  Map<String, dynamic> toJson() => {
    'title': title,
    'tasks': tasks.map((task) => task.toJson()).toList(),
  };

  factory TaskList.fromJson(Map<String, dynamic> json) {
    var tasksFromJson = json['tasks'] as List;
    List<Task> taskList =
    tasksFromJson.map((taskJson) => Task.fromJson(taskJson)).toList();

    return TaskList(
      title: json['title'],
      tasks: taskList,
    );
  }
}

Future<void> saveTaskList(TaskList taskList) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String jsonTaskList = jsonEncode(taskList.toJson());
  await prefs.setString('taskList', jsonTaskList);
}
