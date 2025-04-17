
class Homework {
  final int classroomId;
  final int teacherId;
  final int subjectId;
  final String type;
  final String notes;
  final String date;
  final String homeworkName;

  Homework({
    required this.classroomId,
    required this.teacherId,
    required this.subjectId,
    required this.type,
    required this.notes,
    required this.date,
    required this.homeworkName,
  });

  // تحويل من JSON إلى نموذج
  factory Homework.fromJson(Map<String, dynamic> json) {
    return Homework(
      classroomId: json['classroom_id'],
      teacherId: json['teacher_id'],
      subjectId: json['subject_id'],
      type: json['type'],
      notes: json['notes'],
      date: json['date'],
      homeworkName: json['homework_name'],
    );
  }

  // تحويل من نموذج إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'classroom_id': classroomId,
      'teacher_id': teacherId,
      'subject_id': subjectId,
      'type': type,
      'notes': notes,
      'date': date,
      'homework_name': homeworkName,
    };
  }
}
