class ReplyModel {
  final int id;
  final int teacherId;
  final String teacherName;
  final int questionId;
  final String reply;
  final String createdAt;
  final String updatedAt;

  ReplyModel({
    required this.id,
    required this.teacherId,
    required this.teacherName,
    required this.questionId,
    required this.reply,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ReplyModel.fromJson(Map<String, dynamic> json) {
    return ReplyModel(
      id: json['id'],
      teacherId: json['teacher_id'],
      teacherName: json['teacher_name'],
      questionId: json['question_id'],
      reply: json['reply'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
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
