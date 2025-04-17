// class ProfileModel {
//   final int id;
//   final int classroomId;
//   final int departmentId;
//   final int adviserId;
//   final String name;
//   final String email;
//   final String password;
//   final String phone;
//   final String? image;
//   final String dataBirth;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//   final String classroomName;  // New field for classroom name
//   final String educationStage; // New field for education stage
//
//   ProfileModel({
//     required this.id,
//     required this.classroomId,
//     required this.departmentId,
//     required this.adviserId,
//     required this.name,
//     required this.email,
//     required this.password,
//     required this.phone,
//     this.image,
//     required this.dataBirth,
//     this.createdAt,
//     this.updatedAt,
//     required this.classroomName,  // Initialize the new field
//     required this.educationStage, // Initialize the new field
//   });
//
//   factory ProfileModel.fromJson(Map<String, dynamic> json) {
//     return ProfileModel(
//       id: json['id'],
//       classroomId: json['classroom_id'],
//       departmentId: json['department_id'],
//       adviserId: json['adviser_id'],
//       name: json['first_name'] + ' ' + json['last_name'],
//       email: json['email'],
//       password: json['password'],
//       phone: json['phone'].toString(),
//       image: json['image'] ?? '',
//       dataBirth: json['data_birth'] ?? '',
//       createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
//       updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
//       classroomName: json['classroom']['name'],       // Map the classroom name
//       educationStage: json['education_stage'],  // Map the education stage
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'classroom_id': classroomId,
//       'department_id': departmentId,
//       'adviser_id': adviserId,
//       'name': name,
//       'email': email,
//       'password': password,
//       'phone': phone,
//       'image': image,
//       'data_birth': dataBirth,
//       'created_at': createdAt?.toIso8601String(),
//       'updated_at': updatedAt?.toIso8601String(),
//       'classroom_name': classroomName,       // Add the classroom name to JSON
//       'education_stage': educationStage,  // Add the education stage to JSON
//     };
//   }
// }
class ProfileModel {
  final int id;
  final int classroomId;
  final int departmentId;
  final int adviserId;
  final String name;
  final String email;
  final String password;
  final String phone;
  final String? image;
  final String dataBirth;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String classroomName;
  final String educationStage;

  ProfileModel({
    required this.id,
    required this.classroomId,
    required this.departmentId,
    required this.adviserId,
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    this.image,
    required this.dataBirth,
    this.createdAt,
    this.updatedAt,
    required this.classroomName,
    required this.educationStage,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'],
      classroomId: json['classroom_id'],
      departmentId: json['department_id'],
      adviserId: json['adviser_id'],
      name: json['first_name'] + ' ' + json['last_name'],
      email: json['email'],
      password: json['password'],
      phone: json['phone'].toString(),
      image: json['image'] ?? '',
      dataBirth: json['data_birth'] ?? '',
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
      classroomName: json['classroom']['name'],
      educationStage: json['education_stage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'classroom_id': classroomId,
      'department_id': departmentId,
      'adviser_id': adviserId,
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'image': image,
      'data_birth': dataBirth,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'classroom_name': classroomName,
      'education_stage': educationStage,
    };
  }
}
