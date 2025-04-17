import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:sprint1/StudentApp/Plans/tasks/tasks_screen.dart';

import 'draw/DrawScreen.dart';



class Plans extends StatelessWidget {
  const Plans({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('المخططات'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'رسم'),
              Tab(text: 'مهام'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            DrawingTab(),
            TasksTab(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showChoiceDialog(context);
          },
          backgroundColor: Colors.amber,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
void _showChoiceDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('اختر نوع الوجهة'),
        content: const Text('هل تريد الانتقال إلى واجهة المهام أم واجهة المخططات؟'),
        actions: [
          TextButton(
            child: const Text('مخططات'),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DrawingApp()), // الانتقال إلى شاشة الرسم
              );
            },
          ),
          TextButton(
            child: const Text('مهام'),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TasksScreen()), // الانتقال إلى شاشة المهام
              );
            },
          ),
        ],
      );
    },
  );
}

class DrawingTab extends StatelessWidget {
  const DrawingTab({super.key});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box('drawingsBox');
    return ValueListenableBuilder(
      valueListenable: box.listenable(),
      builder: (context, Box box, _) {
        if (box.isEmpty) {
          return const Center(child: Text('لا يوجد مخططات محفوظة'));
        } else {
          return Directionality(
            textDirection: TextDirection.rtl,  // تعيين الاتجاه إلى من اليمين لليسار
            child: ListView.builder(
              itemCount: box.length,
              itemBuilder: (context, index) {
                final drawingData = box.getAt(index);
                final title = drawingData['title'] ?? 'مخطط غير معنّون'; // استخدام العنوان أو نص افتراضي
                return Card(
                  child: ListTile(
                    title: Text(title),
                    subtitle: Text('${drawingData['date']}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.redAccent),
                      onPressed: () {
                        _deleteDrawing(context, box, index);
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DrawingApp(index: index),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }

  // دالة لحذف المخطط
  void _deleteDrawing(BuildContext context, Box box, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('تأكيد الحذف'),
          content: const Text('هل أنت متأكد أنك تريد حذف هذا المخطط؟'),
          actions: [
            TextButton(
              child: const Text('إلغاء'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('حذف', style: TextStyle(color: Colors.green)),
              onPressed: () {
                box.deleteAt(index);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}




// class TasksTab extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final box = Hive.box('taskBox');
//     return ValueListenableBuilder(
//       valueListenable: box.listenable(),
//       builder: (context, Box box, _) {
//         if (box.isEmpty) {
//           return Center(child: Text('لا يوجد عناصر محفوظة'));
//         } else {
//           return Directionality(
//             textDirection: TextDirection.rtl,
//             child: ListView.builder(
//               itemCount: box.length,
//               itemBuilder: (context, index) {
//                 final taskData = box.getAt(index);
//                 if (taskData is Map<String, dynamic>) {
//                   final title = taskData['title'] ?? 'عنصر غير معنّون';
//                   return Card(
//                     child: ListTile(
//                       title: Text(title),
//                       trailing: IconButton(
//                         icon: Icon(Icons.delete, color: Colors.redAccent),
//                         onPressed: () {
//                           _deleteTask(context, box, index);
//                         },
//                       ),
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => TasksScreen(index: index),
//                           ),
//                         );
//                       },
//                     ),
//                   );
//                 } else {
//                   return Card(
//                     child: ListTile(
//                       title: Text('بيانات غير صحيحة'),
//                     ),
//                   );
//                 }
//
//               },
//             ),
//           );
//         }
//       },
//     );
//   }
//
//   void _deleteTask(BuildContext context, Box box, int index) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('تأكيد الحذف'),
//           content: Text('هل أنت متأكد أنك تريد حذف هذا العنصر؟'),
//           actions: [
//             TextButton(
//               child: Text('إلغاء'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             TextButton(
//               child: Text('حذف', style: TextStyle(color: Colors.green)),
//               onPressed: () {
//                 box.deleteAt(index);
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }


class TasksTab extends StatelessWidget {
  const TasksTab({super.key});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box('taskBox');
    return ValueListenableBuilder(
      valueListenable: box.listenable(),
      builder: (context, Box box, _) {
        if (box.isEmpty) {
          return const Center(child: Text('لا يوجد عناصر محفوظة'));
        } else {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: ListView.builder(
              itemCount: box.length,
              itemBuilder: (context, index) {
                final taskData = box.getAt(index);

                // تحقق من أن البيانات المسترجعة هي خريطة ولديها المفاتيح المطلوبة
                if (taskData is Map && taskData.containsKey('title') && taskData.containsKey('tasks')) {
                  final title = taskData['title'] ?? 'عنصر غير معنّون';
                  return Card(
                    child: ListTile(
                      title: Text(title),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.redAccent),
                        onPressed: () {
                          _deleteTask(context, box, index);
                        },
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TasksScreen(index: index),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  // في حالة فشل التحقق من البيانات، إظهار رسالة "بيانات غير صحيحة"
                  return const Card(
                    child: ListTile(
                      title: Text('بيانات غير صحيحة'),
                    ),
                  );
                }
              },
            ),
          );
        }
      },
    );
  }

  void _deleteTask(BuildContext context, Box box, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('تأكيد الحذف'),
          content: const Text('هل أنت متأكد أنك تريد حذف هذا العنصر؟'),
          actions: [
            TextButton(
              child: const Text('إلغاء'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('حذف', style: TextStyle(color: Colors.green)),
              onPressed: () {
                box.deleteAt(index);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}


// مع زر حذف كلشي
// class TasksTab extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final box = Hive.box('taskBox');
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('مهام'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.delete_forever),
//             onPressed: () {
//               _showClearTasksDialog(context, box);
//             },
//           ),
//         ],
//       ),
//       body: ValueListenableBuilder(
//         valueListenable: box.listenable(),
//         builder: (context, Box box, _) {
//           if (box.isEmpty) {
//             return Center(child: Text('لا يوجد عناصر محفوظة'));
//           } else {
//             return Directionality(
//               textDirection: TextDirection.rtl,
//               child: ListView.builder(
//                 itemCount: box.length,
//                 itemBuilder: (context, index) {
//                   final taskData = box.getAt(index);
//
//                   // تحقق من أن البيانات المسترجعة هي خريطة ولديها المفاتيح المطلوبة
//                   if (taskData is Map && taskData.containsKey('title') && taskData.containsKey('tasks')) {
//                     final title = taskData['title'] ?? 'عنصر غير معنّون';
//                     return Card(
//                       child: ListTile(
//                         title: Text(title),
//                         trailing: IconButton(
//                           icon: Icon(Icons.delete, color: Colors.redAccent),
//                           onPressed: () {
//                             _deleteTask(context, box, index);
//                           },
//                         ),
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => TasksScreen(index: index),
//                             ),
//                           );
//                         },
//                       ),
//                     );
//                   } else {
//                     return Card(
//                       child: ListTile(
//                         title: Text('بيانات غير صحيحة'),
//                       ),
//                     );
//                   }
//                 },
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
//
//   void _deleteTask(BuildContext context, Box box, int index) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('تأكيد الحذف'),
//           content: Text('هل أنت متأكد أنك تريد حذف هذا العنصر؟'),
//           actions: [
//             TextButton(
//               child: Text('إلغاء'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             TextButton(
//               child: Text('حذف', style: TextStyle(color: Colors.green)),
//               onPressed: () {
//                 box.deleteAt(index);
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   void _showClearTasksDialog(BuildContext context, Box box) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('تأكيد المسح'),
//           content: Text('هل أنت متأكد أنك تريد مسح جميع العناصر؟'),
//           actions: [
//             TextButton(
//               child: Text('إلغاء'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             TextButton(
//               child: Text('مسح', style: TextStyle(color: Colors.red)),
//               onPressed: () {
//                 box.clear(); // مسح جميع العناصر
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
