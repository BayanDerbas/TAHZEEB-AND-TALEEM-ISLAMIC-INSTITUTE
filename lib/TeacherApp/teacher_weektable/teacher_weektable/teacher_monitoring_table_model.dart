class TeacherMonitoringTable {
  int? id;
  int? teacherId;
  String? hall;
  String? date;
  String? startTime;
  String? endTime;
  Null createdAt;
  Null updatedAt;

  TeacherMonitoringTable(
      {this.id,
      this.teacherId,
      this.hall,
      this.date,
      this.startTime,
      this.endTime,
      this.createdAt,
      this.updatedAt});

  TeacherMonitoringTable.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    teacherId = json['teacher_id'];
    hall = json['hall'];
    date = json['date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['teacher_id'] = teacherId;
    data['hall'] = hall;
    data['date'] = date;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
