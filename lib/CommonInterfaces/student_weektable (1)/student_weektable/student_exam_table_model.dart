class StudentExamTableModel {
  int? id;
  String? term;
  int? subjectId;
  String? subjectName;
  DateTime? examDate; // Changed from String? to DateTime?
  int? examDuration;
  int? departmentId;
  int? classroomId;
  DateTime? createdAt; // Changed from Null to DateTime?
  DateTime? updatedAt; // Changed from Null to DateTime?

  StudentExamTableModel(
      {this.id,
        this.term,
        this.subjectId,
        this.subjectName,
        this.examDate,
        this.examDuration,
        this.departmentId,
        this.classroomId,
        this.createdAt,
        this.updatedAt});

  StudentExamTableModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    term = json['term'];
    subjectId = json['subject_id'];
    subjectName = json['subject_name'];
    examDate = json['exam_date'] != null ? DateTime.parse(json['exam_date']) : null;
    examDuration = json['exam_duration'];
    departmentId = json['department_id'];
    classroomId = json['classroom_id'];
    createdAt = json['created_at'] != null ? DateTime.parse(json['created_at']) : null;
    updatedAt = json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['term'] = term;
    data['subject_id'] = subjectId;
    data['subject_name'] = subjectName;
    data['exam_date'] = examDate?.toIso8601String();
    data['exam_duration'] = examDuration;
    data['department_id'] = departmentId;
    data['classroom_id'] = classroomId;
    data['created_at'] = createdAt?.toIso8601String();
    data['updated_at'] = updatedAt?.toIso8601String();
    return data;
  }
}
