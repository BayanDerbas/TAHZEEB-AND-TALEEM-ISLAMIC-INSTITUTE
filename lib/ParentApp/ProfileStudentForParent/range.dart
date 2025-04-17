class QuizModel {
  final int subjectId;
  final String type;
  final int finalMark;

  QuizModel({
    required this.subjectId,
    required this.type,
    required this.finalMark,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
      subjectId: json['subject_id'] ?? 0,
      type: json['type'] ?? '',
      finalMark: json['final_mark'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subject_id': subjectId,
      'type': type,
      'final_mark': finalMark,
    };
  }
}
class StudentDegreesModel {
  List<Subject>? subjects;
  double finalAverageMark;

  StudentDegreesModel({required this.subjects, required this.finalAverageMark});

  factory StudentDegreesModel.fromJson(Map<String, dynamic> json) {
    var subjectList = json['subjects'] as List;
    List<Subject> subjectsList = subjectList.map((i) => Subject.fromJson(i)).toList();

    return StudentDegreesModel(
      subjects: subjectsList,
      finalAverageMark: json['finalAverageMark'].toDouble(),
    );
  }
}

class Subject {
  int id;
  String name;
  int classroomId;
  double averageMark;
  List<Quiz> quizzes;

  Subject({required this.id, required this.name, required this.classroomId, required this.averageMark, required this.quizzes});

  factory Subject.fromJson(Map<String, dynamic> json) {
    var quizList = json['quizzes'] as List;
    List<Quiz> quizzesList = quizList.map((i) => Quiz.fromJson(i)).toList();

    return Subject(
      id: json['id'],
      name: json['name'],
      classroomId: json['classroom_id'],
      averageMark: json['average_mark'].toDouble(),
      quizzes: quizzesList,
    );
  }
}

class Quiz {
  int subjectId;
  String type;
  double finalMark;

  Quiz({required this.subjectId, required this.type, required this.finalMark});

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      subjectId: json['subject_id'],
      type: json['type'],
      finalMark: json['final_mark'].toDouble(),
    );
  }
}
