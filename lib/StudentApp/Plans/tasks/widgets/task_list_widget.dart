import 'package:flutter/material.dart';
import 'package:sprint1/StudentApp/Plans/tasks/widgets/task_item_widget.dart';

class TaskListWidget extends StatelessWidget {
  final List<Map<String, dynamic>> tasks;

  const TaskListWidget({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: tasks.map((task) {
        return TaskItemWidget(
          taskName: task['name'],
          isChecked: task['isChecked'],
        );
      }).toList(),
    );
  }
}
