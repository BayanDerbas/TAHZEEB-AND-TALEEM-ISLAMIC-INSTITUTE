class TeacherWeekTableModel {
  int? id;
  String? day;
  int? teacherId;
  int? classroomId;
  String? classroomName;
  String? subjectName;
  String? startTime;
  String? endTime;
  Null createdAt;
  Null updatedAt;

  TeacherWeekTableModel(
      {this.id,
      this.day,
      this.teacherId,
      this.classroomId,
      this.classroomName,
      this.subjectName,
      this.startTime,
      this.endTime,
      this.createdAt,
      this.updatedAt});

  TeacherWeekTableModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    day = json['day'];
    teacherId = json['teacher_id'];
    classroomId = json['classroom_id'];
    classroomName = json['classroom_name'];
    subjectName = json['subject_name'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['day'] = day;
    data['teacher_id'] = teacherId;
    data['classroom_id'] = classroomId;
    data['classroom_name'] = classroomName;
    data['subject_name'] = subjectName;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
