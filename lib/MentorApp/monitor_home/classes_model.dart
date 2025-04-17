class ClassesModel {
  int? id;
  int? departmentId;
  int? monitorId;
  String? name;
  String? createdAt;
  String? updatedAt;

  ClassesModel(
      {this.id,
      this.departmentId,
      this.monitorId,
      this.name,
      this.createdAt,
      this.updatedAt});

  ClassesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    departmentId = json['department_id'];
    monitorId = json['monitor_id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['department_id'] = this.departmentId;
    data['monitor_id'] = this.monitorId;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
