import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'draw/DrawScreen.dart';



class PlansTeacher extends StatelessWidget {
  const PlansTeacher({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('المخططات'),
          ),
        body: const DrawingTab(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const DrawingTeacher()), // الانتقال إلى شاشة الرسم
            );
          },
          backgroundColor: Colors.amber,
          child: const Icon(Icons.add),
        ),
      );
  }
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
                          builder: (context) => DrawingTeacher(index: index),
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


