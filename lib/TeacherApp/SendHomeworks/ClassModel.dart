class Classroom {
  int id;
  String name;

  Classroom({required this.id, required this.name});

  factory Classroom.fromJson(Map<String, dynamic> json) {
    return Classroom(
      id: json['id'],
      name: json['name'],
    );
  }
}
