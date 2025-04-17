
class AdvisorModel {
  final String accessToken;
  final String tokenType;
  final User? user; // User يمكن أن يكون null
  final int expiresIn;

  AdvisorModel({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,

    this.user,
  });

  factory AdvisorModel.fromJson(Map<String, dynamic> json) {
    return AdvisorModel(
      accessToken: json['access_token'],
      tokenType: json['token_type'],
      expiresIn: json['expires_in'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'token_type': tokenType,
      'expires_in': expiresIn,
      'user': user?.toJson(), // سيتم تضمين user فقط إذا كان غير null
    };
  }
}

// class User {
//   final int id;
//   final int monitorId;
//   final int subjectId;
//   final int classroomId;
//   final int departmentId;
//   final String first_name;
//   final String last_name;
//   final String? image;
//   final String email;
//   final String password;
//   final String? fingerPrint;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//
//   User({
//     required this.id,
//     required this.monitorId,
//     required this.subjectId,
//     required this.classroomId,
//     required this.departmentId,
//     this.image,
//     required this.email,
//     required this.password,
//     this.fingerPrint,
//     this.createdAt,
//     this.updatedAt,
//     required this.last_name,
//     required this.first_name,
//   });
//
//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       id: json['id'],
//       monitorId: json['monitor_id'],
//       subjectId: json['subject_id'],
//       classroomId: json['classroom_id'],
//       departmentId: json['department_id'],
//       first_name: json['first_name'],
//       last_name: json['last_name'],
//       image: json['image'],
//       email: json['email'],
//       password: json['password'],
//       fingerPrint: json['fingerPrint'],
//       createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
//       updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'monitor_id': monitorId,
//       'subject_id': subjectId,
//       'classroom_id': classroomId,
//       'department_id': departmentId,
//       'first_name': first_name,
//       'last_name': last_name,
//       'image': image,
//       'email': email,
//       'password': password,
//       'fingerPrint': fingerPrint,
//       'created_at': createdAt?.toIso8601String(),
//       'updated_at': updatedAt?.toIso8601String(),
//     };
//   }
// }
class User {
  final int id;
  final String firstName;
  final String lastName;
  final String password;
  final String fullName;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.fullName,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      password: json['password'],
      fullName: json['full_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'password': password,
      'full_name': fullName,
    };
  }
}