class UserModel {
  final int id;
  final int classroomId;
  final int departmentId;
  final int adviserId;
  final String firstName;
  final String lastName;
  final String email;
  final String password; // حسب البيانات، إذا كان هذا حقلًا حساسًا، قد ترغب في معالجته بحذر
  final int phone;
  final String? image;
  final String dataBirth;
  final String? createdAt;
  final String? updatedAt;

  UserModel({
    required this.id,
    required this.classroomId,
    required this.departmentId,
    required this.adviserId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.phone,
    this.image,
    required this.dataBirth,
    this.createdAt,
    this.updatedAt,
  });

  // تحويل JSON إلى كائن Dart
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      classroomId: json['classroom_id'] as int,
      departmentId: json['department_id'] as int,
      adviserId: json['adviser_id'] as int,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      phone: json['phone'] as int,
      image: json['image'] as String?,
      dataBirth: json['data_birth'] as String,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  // تحويل كائن Dart إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'classroom_id': classroomId,
      'department_id': departmentId,
      'adviser_id': adviserId,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'password': password,
      'phone': phone,
      'image': image,
      'data_birth': dataBirth,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
