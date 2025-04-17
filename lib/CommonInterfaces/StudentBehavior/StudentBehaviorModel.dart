// student_behavior_model.dart
import 'package:intl/intl.dart';

class StudentBehavior {
  final int id;
  final String note;
  final String sentBy;
  final String type;
  final String sentAt;

  StudentBehavior({
    required this.id,
    required this.note,
    required this.sentBy,
    required this.type,
    required this.sentAt,
  });

  factory StudentBehavior.fromJson(Map<String, dynamic> json) {
    // Assuming the date string in the JSON is in a format that DateTime.parse can handle.
    DateTime dateTime = DateTime.parse(json['sent_at']);

    // Formatting the date to only include the date part (e.g., yyyy-MM-dd).
    String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);

    return StudentBehavior(
      id: json['id'],
      note: json['note'],
      sentBy: json['sent_by'],
      type: json['type'],
      sentAt: formattedDate,
    );
  }
}
