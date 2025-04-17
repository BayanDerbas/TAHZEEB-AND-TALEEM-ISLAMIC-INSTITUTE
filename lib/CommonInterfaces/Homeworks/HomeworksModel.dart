// models/homework.dart

import 'package:intl/intl.dart';

class Homework {
  final int id;
  final int subjectId;
  final int teacherId;
  final int classroomId;
  final String homeworkName;
  final String type;
  final String notes;
  final String date;
  final String classroomName;
  final String subjectName;

  Homework({
    required this.id,
    required this.subjectId,
    required this.teacherId,
    required this.classroomId,
    required this.homeworkName,
    required this.type,
    required this.notes,
    required this.date,
    required this.classroomName,
    required this.subjectName,
  });

  factory Homework.fromJson(Map<String, dynamic> json) {
    DateTime dateTime = DateTime.parse(json['date']);

    // Formatting the date to only include the date part (e.g., yyyy-MM-dd).
    String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);

    return Homework(
      id: json['id'],
      subjectId: json['subject_id'],
      teacherId: json['teacher_id'],
      classroomId: json['classroom_id'],
      homeworkName: json['homework_name'],
      type: json['type'],
      notes: json['notes'],
      date: formattedDate,
      classroomName: json['classroom_name'],
      subjectName: json['subject_name'],
    );
  }
}
