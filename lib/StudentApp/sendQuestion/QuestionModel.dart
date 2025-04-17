// lib/model/question_model.dart
class QuestionModel {
  final int studentId;
  final int subjectId;
  final String question;


  QuestionModel({
    required this.studentId,
    required this.subjectId,
    required this.question,
  });

  Map<String, dynamic> toJson() {
    return {
      'student_id': studentId,
      'subject_id': subjectId,
      'question': question,
    };
  }
}
