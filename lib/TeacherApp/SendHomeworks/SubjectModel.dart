class Subject {
  int id;
  String name;
  int classroomId;

  Subject({required this.id, required this.name, required this.classroomId});

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['id'],
      name: json['name'],
      classroomId: json['classroom_id'],
    );
  }
}
