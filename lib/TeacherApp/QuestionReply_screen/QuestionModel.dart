class QuestionModel {
  final int id;
  final int teacherId;
  final int studentId;
  final String studentName;
  final String question;
  final String answered;
  final String? createdAt;
  final String? updatedAt;

  QuestionModel({
    required this.id,
    required this.teacherId,
    required this.studentId,
    required this.studentName,
    required this.question,
    required this.answered,
    this.createdAt,
    this.updatedAt,
  });

  // Factory constructor to create a QuestionModel from JSON
  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'],
      teacherId: json['teacher_id'],
      studentId: json['student_id'],
      studentName: json['student_name'],
      question: json['question'],
      answered: json['answered'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  // Method to convert a QuestionModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'teacher_id': teacherId,
      'student_id': studentId,
      'student_name': studentName,
      'question': question,
      'answered': answered,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
