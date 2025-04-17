class ConsultModel {
  final int studentId;
  final int adviserId;
  final String consult;
  final bool isAnonymous;
  final DateTime updatedAt;
  final DateTime createdAt;
  final int id;

  ConsultModel({
    required this.studentId,
    required this.adviserId,
    required this.consult,
    required this.isAnonymous,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory ConsultModel.fromJson(Map<String, dynamic> json) {
    return ConsultModel(
      studentId: json['student_id'],
      adviserId: json['adviser_id'],
      consult: json['consult'],
      isAnonymous: json['is_anonymous'] == '1',
      updatedAt: DateTime.parse(json['updated_at']),
      createdAt: DateTime.parse(json['created_at']),
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'student_id': studentId,
      'adviser_id': adviserId,
      'consult': consult,
      'is_anonymous': isAnonymous ? '1' : '0',
      'updated_at': updatedAt.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'id': id,
    };
  }
}
