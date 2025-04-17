import 'package:flutter/material.dart';

class AddTaskBottomSheetWidget extends StatelessWidget {
  final Function(String) onTaskAdded;

  AddTaskBottomSheetWidget({super.key, required this.onTaskAdded});

  final TextEditingController _taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 16.0,
          left: 16.0,
          right: 16.0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _taskController,
              decoration: const InputDecoration(
                labelText: 'عنوان المهمة',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final taskName = _taskController.text;
                if (taskName.isNotEmpty) {
                  onTaskAdded(taskName);
                  Navigator.pop(context);
                }
              },
              child: const Text('إضافة'),
            ),
          ],
        ),
      ),
    );
  }
}