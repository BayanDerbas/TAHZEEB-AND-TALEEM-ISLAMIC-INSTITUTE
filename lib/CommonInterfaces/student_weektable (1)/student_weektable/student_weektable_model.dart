// class StudentWeektableModel {
//   int? id;
//   String? term;
//   int? subjectId;
//   String? subjectName;
//   String? day;
//   Null session;
//   int? departmentId;
//   int? classroomId;
//   Null createdAt;
//   Null updatedAt;
//
//   StudentWeektableModel(
//       {this.id,
//       this.term,
//       this.subjectId,
//       this.subjectName,
//       this.day,
//       this.session,
//       this.departmentId,
//       this.classroomId,
//       this.createdAt,
//       this.updatedAt});
//
//   StudentWeektableModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     term = json['term'];
//     subjectId = json['subject_id'];
//     subjectName = json['subject_name'];
//     day = json['day'];
//     session = json['session'];
//     departmentId = json['department_id'];
//     classroomId = json['classroom_id'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['term'] = term;
//     data['subject_id'] = subjectId;
//     data['subject_name'] = subjectName;
//     data['day'] = day;
//     data['session'] = session;
//     data['department_id'] = departmentId;
//     data['classroom_id'] = classroomId;
//     data['created_at'] = createdAt;
//     data['updated_at'] = updatedAt;
//     return data;
//   }
// }
class StudentWeektableModel {
  int? id;
  String? term;
  int? subjectId;
  String? subjectName;
  String? day;
  String? session; // Changed from Null to String?
  int? departmentId;
  int? classroomId;
  DateTime? createdAt; // Changed from Null to DateTime?
  DateTime? updatedAt; // Changed from Null to DateTime?

  StudentWeektableModel(
      {this.id,
        this.term,
        this.subjectId,
        this.subjectName,
        this.day,
        this.session,
        this.departmentId,
        this.classroomId,
        this.createdAt,
        this.updatedAt});

  StudentWeektableModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    term = json['term'];
    subjectId = json['subject_id'];
    subjectName = json['subject_name'];
    day = json['day'];
    session = json['session']; // Now it's correctly handled as String?
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
    data['day'] = day;
    data['session'] = session;
    data['department_id'] = departmentId;
    data['classroom_id'] = classroomId;
    data['created_at'] = createdAt?.toIso8601String();
    data['updated_at'] = updatedAt?.toIso8601String();
    return data;
  }
}
