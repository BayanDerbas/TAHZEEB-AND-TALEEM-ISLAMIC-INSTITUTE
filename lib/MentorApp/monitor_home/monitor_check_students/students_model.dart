class StudentsModel {
  List<CheckListAttendance>? checkListAttendance;

  StudentsModel({this.checkListAttendance});

  StudentsModel.fromJson(Map<String, dynamic> json) {
    if (json['check_list_Attendance'] != null) {
      checkListAttendance = <CheckListAttendance>[];
      json['check_list_Attendance'].forEach((v) {
        checkListAttendance!.add(new CheckListAttendance.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.checkListAttendance != null) {
      data['check_list_Attendance'] =
          this.checkListAttendance!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class CheckListAttendance {
  int? id;
  int? classroomId;
  int? departmentId;
  int? adviserId;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  int? phone;
  String? image; // Changed from Null? to String?
  String? dataBirth;
  String? createdAt; // Changed from Null? to String?
  String? updatedAt; // Changed from Null? to String?

  CheckListAttendance(
      {this.id,
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
        this.updatedAt});

  CheckListAttendance.fromJson(Map<String, dynamic> json) {
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['classroom_id'] = this.classroomId;
    data['department_id'] = this.departmentId;
    data['adviser_id'] = this.adviserId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['password'] = this.password;
    data['phone'] = this.phone;
    data['image'] = this.image;
    data['data_birth'] = this.dataBirth;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}


