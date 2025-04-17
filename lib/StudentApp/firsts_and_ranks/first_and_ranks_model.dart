class FirstsAndRanksModel {
  int? id;
  int? classroomId;
  int? departmentId;
  int? adviserId;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  int? phone;
  String? image;  // Changed from Null to String?
  String? dataBirth;
  String? createdAt;  // Changed from Null to String?
  String? updatedAt;  // Changed from Null to String?
  double? totalMarks;
  int? rank;

  FirstsAndRanksModel({
    this.id,
    this.classroomId,
    this.departmentId,
    this.adviserId,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.phone,
    this.image,
    this.dataBirth,
    this.createdAt,
    this.updatedAt,
    this.totalMarks,
    this.rank,
  });

  FirstsAndRanksModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    classroomId = json['classroom_id'];
    departmentId = json['department_id'];
    adviserId = json['adviser_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    image = json['image'];
    dataBirth = json['data_birth'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];

    // Convert total_marks to double if it's an int
    totalMarks = json['total_marks']?.toDouble();
    rank = json['rank'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['classroom_id'] = classroomId;
    data['department_id'] = departmentId;
    data['adviser_id'] = adviserId;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['password'] = password;
    data['phone'] = phone;
    data['image'] = image;
    data['data_birth'] = dataBirth;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['total_marks'] = totalMarks;
    data['rank'] = rank;
    return data;
  }
}
