import 'package:intl/intl.dart';

class ConsultModel {
  final int studentId;
  final int adviserId;
  final String consult;
  final bool isAnonymous;
  final String answered; // Keep answered as String
  final String updatedAt;
  final String createdAt;
  final int id;

  ConsultModel({
    required this.studentId,
    required this.adviserId,
    required this.consult,
    required this.isAnonymous,
    required this.updatedAt,
    required this.answered,
    required this.createdAt,
    required this.id,
  });

  factory ConsultModel.fromJson(Map<String, dynamic> json) {
    DateTime dateTime = DateTime.parse(json['created_at']);

    // Formatting the date to only include the date part (e.g., yyyy-MM-dd).
    String formattedDate = DateFormat('MM/dd').format(dateTime);
    String format = DateFormat('HH:mm').format(dateTime);
    return ConsultModel(
      studentId: json['student_id'],
      adviserId: json['adviser_id'],
      consult: json['consult'],
      isAnonymous: json['is_anonymous'] == '1',
      updatedAt: format,
      createdAt: formattedDate,
      id: json['id'],
      answered: json['answered'] ?? '0',  // If answered is null, default to '0'
    );
  }

  Map<String, dynamic> toJson() {

    final DateFormat timeFormat = DateFormat('HH:mm'); // HH:mm for hour and minute

    return {
      'student_id': studentId,
      'adviser_id': adviserId,
      'consult': consult,
      'is_anonymous': isAnonymous ? '1' : '0',
      'updated_at': updatedAt,
      'created_at': createdAt, // Format to HH:mm
      'id': id,
      'answered': answered,
    };
  }
}
