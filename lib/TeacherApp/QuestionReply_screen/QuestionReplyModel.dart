class ReplyModel {
  final String questionText;
  final String studentName;
  final Answer answer;

  ReplyModel({
    required this.questionText,
    required this.studentName,
    required this.answer,
  });

  factory ReplyModel.fromJson(Map<String, dynamic> json) {
    return ReplyModel(
      questionText: json['question_text'] as String,
      studentName: json['student_name'] as String,
      answer: Answer.fromJson(json['answer']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question_text': questionText,
      'student_name': studentName,
      'answer': answer.toJson(),
    };
  }
}

class Answer {
  final String reply;
  final int teacherId;
  final int questionId;
  final String createdAt;
  final String updatedAt;
  final int id;

  Answer({
    required this.reply,
    required this.teacherId,
    required this.questionId,
    required this.createdAt,
    required this.updatedAt,
    required this.id,
  });

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      reply: json['reply'] as String,
      teacherId: json['teacher_id'] as int,
      questionId: json['question_id'] as int,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
      id: json['id'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reply': reply,
      'teacher_id': teacherId,
      'question_id': questionId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'id': id,
    };
  }
}
