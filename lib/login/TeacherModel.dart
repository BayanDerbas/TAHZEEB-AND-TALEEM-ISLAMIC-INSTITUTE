
class TeacherModel {
  final String accessToken;
  final String tokenType;
  final int expiresIn;
  final User user;

  TeacherModel({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
    required this.user,
  });

  factory TeacherModel.fromJson(Map<String, dynamic> json) {
    return TeacherModel(
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
  final int subjectId;
  final int departmentId;
  final String first_name;
  final String last_name;
  final String? image;
  final String email;
  final String password;
  final String? fingerPrint;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  User({
    required this.id,
    required this.subjectId,
    required this.departmentId,
    this.image,
    required this.email,
    required this.password,
    this.fingerPrint,
    this.createdAt,
    this.updatedAt,
    required this.last_name,
    required this.first_name,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      subjectId: json['subject_id'],

      departmentId: json['department_id'],
      first_name: json['first_name'],
      last_name: json['last_name'],
      image: json['image'],
      email: json['email'],
      password: json['password'],
      fingerPrint: json['fingerPrint'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'subject_id': subjectId,
      'department_id': departmentId,
      'first_name': first_name,
      'last_name': last_name,
      'image': image,
      'email': email,
      'password': password,
      'fingerPrint': fingerPrint,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
