import 'package:intl/intl.dart';

class StudentQuestion {
  final int id;
  final String studentName;
  final String consult;
  final String answered; // Keep answered as String
  final String updatedAt;
  final String createdAt;
  StudentQuestion({
    required this.id,
    required this.studentName,
    required this.consult,
    required this.answered,
    required this.updatedAt,
    required this.createdAt,

  });

  factory StudentQuestion.fromJson(Map<String, dynamic> json) {
    DateTime dateTime = DateTime.parse(json['created_at']);

    // Formatting the date to only include the date part (e.g., yyyy-MM-dd).
    String formattedDate = DateFormat('MM/dd').format(dateTime);
    String format = DateFormat('HH:mm').format(dateTime);

    return StudentQuestion(
      updatedAt: format,
      createdAt: formattedDate,
      id: json['id'] ?? 0,  // If id is null, default to 0
      studentName: json['student_name'] ?? '',  // If student_name is null, default to an empty string
      consult: json['question'] ?? '',  // If question is null, default to an empty string
      answered: json['answered'] ?? '0',  // If answered is null, default to '0'
    );
  }
}
