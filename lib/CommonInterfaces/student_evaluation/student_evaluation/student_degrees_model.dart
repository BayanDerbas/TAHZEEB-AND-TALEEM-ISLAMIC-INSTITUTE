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
}

class Subjects {
  int? id;
  String? name;
  int? classroomId;
  int? averageMark;

  Subjects({this.id, this.name, this.classroomId, this.averageMark});

  Subjects.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    classroomId = json['classroom_id'];
    averageMark = json['average_mark'];
  }
}
