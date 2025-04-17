// import 'package:flutter/material.dart';
// import 'package:sprint1/Draw/tasks/widgets/task_list_widget.dart';
// class PlanCardWidget extends StatelessWidget {
//   final List<Map<String, dynamic>> tasks;
//
//   const PlanCardWidget({super.key, required this.tasks});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(16.0),
//       decoration: BoxDecoration(
//         color: Colors.grey[300],
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'العنوان',
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           SizedBox(height: 16),
//           TaskListWidget(tasks: tasks),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class PlanCardWidget extends StatelessWidget {
  final List<Map<String, dynamic>> tasks;

  const PlanCardWidget({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            contentPadding: const EdgeInsets.all(8),
            title: Text(task['name']),
            trailing: Checkbox(
              value: task['isChecked'],
              onChanged: (bool? value) {
                // تحديث حالة التحقق في Hive
                final updatedTask = {...task, 'isChecked': value};
                final box = Hive.box('tasksBox');
                box.putAt(index, updatedTask);
              },
            ),
          ),
        );
      },
    );
  }
}
