class ConsultModel {
  final int id;
  final int adviserId;
  final int studentId;
  final String studentName;
  final String consult;

  ConsultModel({
    required this.id,
    required this.adviserId,
    required this.studentId,
    required this.studentName,
    required this.consult,
  });

  factory ConsultModel.fromJson(Map<String, dynamic> json) {
    return ConsultModel(
      id: json['id'],
      adviserId: json['adviser_id'],
      studentId: json['student_id'],
      studentName: json['student_name'],
      consult: json['consult'],
    );
  }
}
