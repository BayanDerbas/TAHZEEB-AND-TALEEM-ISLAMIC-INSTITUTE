class StudentDegreesModel {
  List<Subjects>? subjects;

  StudentDegreesModel({this.subjects});

  StudentDegreesModel.fromJson(Map<String, dynamic> json) {
    if (json['subjects'] != null) {
      subjects = <Subjects>[];
      json['subjects'].forEach((v) {
        subjects!.add(Subjects.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (subjects != null) {
      data['subjects'] = subjects!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subjects {
  int? id;
  String? name;
  int? classroomId;
  int? averageMark;
  List<Quizzes>? quizzes;

  Subjects(
      {this.id, this.name, this.classroomId, this.averageMark, this.quizzes});

  Subjects.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    classroomId = json['classroom_id'];
    averageMark = json['average_mark'];
    if (json['quizzes'] != null) {
      quizzes = <Quizzes>[];
      json['quizzes'].forEach((v) {
        quizzes!.add(Quizzes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['classroom_id'] = classroomId;
    data['average_mark'] = averageMark;
    if (quizzes != null) {
      data['quizzes'] = quizzes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Quizzes {
  int? subjectId;
  String? type;
  int? finalMark;

  Quizzes({this.subjectId, this.type, this.finalMark});

  Quizzes.fromJson(Map<String, dynamic> json) {
    subjectId = json['subject_id'];
    type = json['type'];
    finalMark = json['final_mark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subject_id'] = subjectId;
    data['type'] = type;
    data['final_mark'] = finalMark;
    return data;
  }
}
