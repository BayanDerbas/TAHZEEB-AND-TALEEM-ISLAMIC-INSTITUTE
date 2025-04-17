// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:hive_flutter/adapters.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:sprint1/Draw/tasks/widgets/add_task_bottom_sheet_widget.dart';
//
// class TasksScreen extends StatefulWidget {
//   final int? index;
//   TasksScreen({this.index});
//
//   @override
//   State<TasksScreen> createState() => _TasksScreenState();
// }
//
// class _TasksScreenState extends State<TasksScreen> {
//   List<Map<String, dynamic>> _tasks = [];
//   String? _taskTitle;
//
//   @override
//   void initState() {
//     super.initState();
//     if (widget.index != null) {
//       _loadTasks(widget.index!);
//     }
//   }
//
//   // Future<void> _loadTasks(int index) async {
//   //   try {
//   //     final box = await Hive.openBox('taskBox');
//   //     final taskData = box.getAt(index);
//   //     print('Loading tasks at index $index: $taskData'); // Added print statement
//   //     if (taskData != null && taskData is Map<String, dynamic>) {
//   //       setState(() {
//   //         _tasks = List<Map<String, dynamic>>.from(taskData['tasks'] ?? []);
//   //         _taskTitle = taskData['title'];
//   //       });
//   //     } else {
//   //       print('No task data found at index $index'); // Added print statement
//   //       setState(() {
//   //         _tasks = [];
//   //         _taskTitle = null;
//   //       });
//   //     }
//   //   } catch (e) {
//   //     print('Error loading tasks: $e'); // Added print statement for error
//   //   }
//   // }
//   // Future<void> _loadTasks(int index) async {
//   //   try {
//   //     final box = await Hive.openBox('taskBox');
//   //     final taskData = box.getAt(index);
//   //     print('Loading tasks at index $index: $taskData'); // طباعة البيانات المحملة
//   //
//   //     if (taskData != null) {
//   //       print('Loaded taskData: ${taskData.toString()}'); // طباعة البيانات المحملة بعد التحقق
//   //
//   //       setState(() {
//   //         _tasks = List<Map<String, dynamic>>.from(taskData['tasks'] ?? []);
//   //         _taskTitle = taskData['title'];
//   //       });
//   //
//   //       print('Tasks after setState: $_tasks'); // طباعة حالة _tasks بعد setState
//   //     } else {
//   //       print('No task data found at index $index'); // طباعة رسالة عندما لا يتم العثور على بيانات
//   //       setState(() {
//   //         _tasks = [];
//   //         _taskTitle = null;
//   //       });
//   //     }
//   //   } catch (e) {
//   //     print('Error loading tasks: $e'); // طباعة أي أخطاء قد تحدث
//   //   }
//   // }
//   Future<void> _loadTasks(int index) async {
//     try {
//       final box = await Hive.openBox('taskBox');
//       final taskData = box.getAt(index);
//       print('Loading tasks at index $index: $taskData'); // طباعة البيانات المحملة
//
//       if (taskData != null) {
//         // تأكد من أن البيانات هي Map<String, dynamic>
//         final Map<String, dynamic> taskDataMap = Map<String, dynamic>.from(taskData);
//
//         print('Loaded taskData: ${taskDataMap.toString()}'); // طباعة البيانات المحملة بعد التحقق
//
//         setState(() {
//           _tasks = List<Map<String, dynamic>>.from(taskDataMap['tasks'] ?? []);
//           _taskTitle = taskDataMap['title'];
//         });
//
//         print('Tasks after setState: $_tasks'); // طباعة حالة _tasks بعد setState
//       } else {
//         print('No task data found at index $index'); // طباعة رسالة عندما لا يتم العثور على بيانات
//         setState(() {
//           _tasks = [];
//           _taskTitle = null;
//         });
//       }
//     } catch (e) {
//       print('Error loading tasks: $e'); // طباعة أي أخطاء قد تحدث
//     }
//   }
//
//   Future<void> _save() async {
//     try {
//       final box = await Hive.openBox('taskBox');
//       if (_taskTitle != null && _tasks.isNotEmpty) {
//         final taskData = {
//           'title': _taskTitle,
//           'tasks': _tasks,
//         };
//         if (widget.index != null) {
//           await box.putAt(widget.index!, taskData);
//           print('Updated tasks at index ${widget.index!} with data: $taskData'); // Added print statement
//         } else {
//           await box.add(taskData);
//           print('Added new tasks with data: $taskData'); // Added print statement
//         }
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('تم حفظ المهام بنجاح!')),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('الرجاء إدخال عنوان للمهام وإضافة مهام.')),
//         );
//       }
//     } catch (e) {
//       print('Error saving tasks: $e'); // Added print statement for error
//     }
//   }
//
//   Future<void> _getTitleFromUser() async {
//     final TextEditingController titleController = TextEditingController();
//     await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('أدخل العنوان'),
//           content: TextField(
//             controller: titleController,
//             decoration: InputDecoration(hintText: 'أدخل عنواناً للمهام'),
//           ),
//           actions: [
//             TextButton(
//               child: Text('إلغاء'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             TextButton(
//               child: Text('حفظ'),
//               onPressed: () {
//                 setState(() {
//                   _taskTitle = titleController.text;
//                 });
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     print('Building TasksScreen with tasks: $_tasks'); // طباعة حالة _tasks عند البناء
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       appBar: AppBar(
//         title: Text('المخططات'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.title),
//             onPressed: _getTitleFromUser,
//           ),
//           IconButton(
//             icon: Icon(Icons.save),
//             onPressed: _save,
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           _showAddTaskBottomSheet(context);
//         },
//         shape: CircleBorder(),
//         backgroundColor: Color(0Xfffcd511),
//         child: Icon(
//           Icons.add,
//           color: Colors.white,
//         ),
//       ),
//       body: _tasks.isEmpty
//           ? Center(child: Text('لا توجد مهام'))
//           : ListView.builder(
//         padding: const EdgeInsets.all(16.0),
//         itemCount: _tasks.length,
//         itemBuilder: (context, index) {
//           print('Building ListTile for task: ${_tasks[index]}'); // طباعة كل مهمة عند البناء
//           return ListTile(
//             title: Text(_tasks[index]['name']),
//             trailing: Checkbox(
//               value: _tasks[index]['isChecked'],
//               onChanged: (bool? value) {
//                 setState(() {
//                   _tasks[index]['isChecked'] = value ?? false;
//                 });
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   void _showAddTaskBottomSheet(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       builder: (context) {
//         return AddTaskBottomSheetWidget(
//           onTaskAdded: (taskName) {
//             setState(() {
//               _tasks.add({'name': taskName, 'isChecked': false});
//               print('Added new task: $taskName'); // Added print statement
//             });
//           },
//         );
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sprint1/StudentApp/Plans/tasks/widgets/add_task_bottom_sheet_widget.dart';


class TasksScreen extends StatefulWidget {
  final int? index;
  const TasksScreen({super.key, this.index});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  List<Map<String, dynamic>> _tasks = [];
  List<Map<dynamic, dynamic>> _tasksfromhive = [];
  String? _taskTitle;

  @override
  void initState() {
    super.initState();
    if (widget.index != null) {
      _loadTasks(widget.index!);
    }
  }

  // Future<void> _loadTasks(int index) async {
  //   try {
  //     final box = await Hive.openBox('taskBox');
  //     final taskData = box.getAt(index);
  //     print('Loading tasks at index $index: $taskData'); // Debugging
  //
  //     if (taskData != null && taskData is Map) {
  //       // Safely cast to Map<String, dynamic>
  //       final taskDataMap = Map<String, dynamic>.from(taskData as Map);
  //
  //       print('Loaded taskData: ${taskDataMap.toString()}'); // Debugging
  //
  //       setState(() {
  //         _tasks = List<Map<String, dynamic>>.from(taskDataMap['tasks'] ?? []);
  //         _taskTitle = taskDataMap['title'];
  //       });
  //
  //       print('Tasks after setState: $_tasks'); // Debugging
  //     } else {
  //       print('No task data found at index $index'); // Debugging
  //       setState(() {
  //         _tasks = [];
  //         _taskTitle = null;
  //       });
  //     }
  //   } catch (e) {
  //     print('Error loading tasks: $e'); // Debugging
  //   }
  // }
  // Future<void> _loadTasks(int index) async {
  //   try {
  //     final box = await Hive.openBox('taskBox');
  //     final taskData = box.getAt(index);
  //     print('Loading tasks at index $index: $taskData'); // Debugging
  //
  //     if (taskData != null) {
  //       if (taskData is Map) {
  //         // Convert Map<dynamic, dynamic> to Map<String, dynamic>
  //         final Map<String, dynamic> taskDataMap = Map<String, dynamic>.from(taskData);
  //
  //         print('Loaded taskData: ${taskDataMap.toString()}'); // Debugging
  //
  //         setState(() {
  //           _tasks = List<Map<String, dynamic>>.from(taskDataMap['tasks'] ?? []);
  //           _taskTitle = taskDataMap['title'];
  //         });
  //
  //         print('Tasks after setState: $_tasks'); // Debugging
  //       } else {
  //         print('Expected a Map but got ${taskData.runtimeType}'); // Debugging
  //         setState(() {
  //           _tasks = [];
  //           _taskTitle = null;
  //         });
  //       }
  //     } else {
  //       print('No task data found at index $index'); // Debugging
  //       setState(() {
  //         _tasks = [];
  //         _taskTitle = null;
  //       });
  //     }
  //   } catch (e) {
  //     print('Error loading tasks: $e'); // Debugging
  //   }
  // }
  Future<void> _loadTasks(int index) async {
    try {
      final box = await Hive.openBox('taskBox');
      final taskData = box.getAt(index);
      print('Loading tasks at index $index: $taskData'); // Debugging

      if (taskData != null && taskData is Map) {
        final Map<String, dynamic> taskDataMap = Map<String, dynamic>.from(taskData);

        print('Loaded taskData: ${taskDataMap.toString()}'); // Debugging

        // Convert to a List of tasks
        final List<dynamic> tasksFromHive = taskDataMap['tasks'] ?? [];
        print('عععععععععععععععععععععععععععععععععععععععععع'); // Debugging

        _tasksfromhive = List<Map<dynamic, dynamic>>.from(tasksFromHive);
        print('للللللللللللللللللللللللللللللللللللللللللللللل'); // Debugging

        setState(() {
          _tasks = List<Map<String, dynamic>>.from(_tasksfromhive);
          print('فففففففففففففففففففففففففففففففففففففففففففف'); // Debugging
          _taskTitle = taskDataMap['title'];
        });

        print('Tasks after setState: $_tasks'); // Debugging
      } else {
        print('No task data found at index $index'); // Debugging
        setState(() {
          _tasks = [];
          _taskTitle = null;
        });
      }
    } catch (e) {
      print('Error loading tasks: $e'); // Debugging
    }
  }

  Future<void> _save() async {
    try {
      final box = await Hive.openBox('taskBox');
      if (_taskTitle != null && _tasks.isNotEmpty) {
        final taskData = {
          'title': _taskTitle,
          'tasks': _tasks, // Ensure this is the data you want to save
        };
        if (widget.index != null) {
          await box.putAt(widget.index!, taskData);
          print('Updated tasks at index ${widget.index!} with data: $taskData'); // Debugging
        } else {
          await box.add(taskData);
          print('Added new tasks with data: $taskData'); // Debugging
        }
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تم حفظ المهام بنجاح!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('الرجاء إدخال عنوان للمهام وإضافة مهام.')),
        );
      }
    } catch (e) {
      print('Error saving tasks: $e'); // Debugging
    }
  }


  Future<void> _getTitleFromUser() async {
    final TextEditingController titleController = TextEditingController();
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('أدخل العنوان'),
          content: TextField(
            controller: titleController,
            decoration: const InputDecoration(hintText: 'أدخل عنواناً للمهام'),
          ),
          actions: [
            TextButton(
              child: const Text('إلغاء'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('حفظ'),
              onPressed: () {
                setState(() {
                  _taskTitle = titleController.text;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print('Building TasksScreen with tasks: $_tasks'); // Debugging
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('المخططات'),
        actions: [
          IconButton(
            icon: const Icon(Icons.title),
            onPressed: _getTitleFromUser,
          ),
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _save,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTaskBottomSheet(context);
        },
        shape: const CircleBorder(),
        backgroundColor: const Color(0Xfffcd511),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: _tasks.isEmpty
          ? const Center(child: Text('لا توجد مهام'))
          : ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _tasks.length,
        itemBuilder: (context, index) {
          print('Building ListTile for task: ${_tasks[index]}'); // Debugging
          return ListTile(
            title: Text(_tasks[index]['name']),
            trailing: Checkbox(
              value: _tasks[index]['isChecked'],
              onChanged: (bool? value) {
                setState(() {
                  _tasks[index]['isChecked'] = value ?? false;
                });
              },
            ),
          );
        },
      ),
    );
  }

  void _showAddTaskBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return AddTaskBottomSheetWidget(
          onTaskAdded: (taskName) {
            setState(() {
              _tasks.add({'name': taskName, 'isChecked': false});
              print('Added new task: $taskName'); // Debugging
            });
          },
        );
      },
    );
  }
}
