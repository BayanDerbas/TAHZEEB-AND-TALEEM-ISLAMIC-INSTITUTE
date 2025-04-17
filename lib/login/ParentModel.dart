

class ParentModel {
  final String accessToken;
  final String tokenType;
  final int expiresIn;
  final User user;

  ParentModel({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
    required this.user,
  });

  factory ParentModel.fromJson(Map<String, dynamic> json) {
    return ParentModel(
      accessToken: json['access_token'],
      tokenType: json['token_type'],
      expiresIn: json['expires_in'],
      user: User.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'token_type': tokenType,
      'expires_in': expiresIn,
      'user': user.toJson(),
    };
  }
}

class User {
  final int id;
  final String first_name;
  final String last_name;
  final String student_name;
  final String email;
  final int studentId;
  final int classroomId;
  final String classroomName;
  final String password;
  final int phone;
  final String? image;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  User({
    required this.id,
    required this.first_name,
    required this.last_name,
    required this.student_name,
    required this.email,
    required this.studentId,
    required this.classroomId,
    required this.classroomName,
    required this.password,
    required this.phone,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      first_name: json['first_name'],
      last_name: json['last_name'],
      student_name: json['student_name'],
      email: json['email'],
      studentId: json['student_id'],
      classroomId: json['classroom_id'],
      classroomName: json['classroom_name'],
      password: json['password'],
      phone: json['phone'],
      image: json['image'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': first_name,
      'last_name': last_name,
      'student_name': student_name,
      'classroom_name': classroomName,
      'classroom_id': classroomId,
      'email': email,
      'student_id': studentId,
      'password': password,
      'phone': phone,
      'image': image,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
