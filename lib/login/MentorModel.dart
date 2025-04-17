
class MentorModel {
  final String accessToken;
  final String tokenType;
  final int expiresIn;
  final User? user; // User يمكن أن يكون null

  MentorModel({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
    this.user,
  });

  factory MentorModel.fromJson(Map<String, dynamic> json) {
    return MentorModel(
      accessToken: json['access_token'],
      tokenType: json['token_type'],
      expiresIn: json['expires_in'] ?? 0, // تعيين قيمة افتراضية إذا كانت `expires_in` `null`
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'token_type': tokenType,
      'expires_in': expiresIn,
      'user': user?.toJson(),
    };
  }
}

class User {
  final int id;
  final String first_name;
  final String last_name;
  final String password;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  User({
    required this.id,
    required this.password,
    this.createdAt,
    this.updatedAt,
    required this.last_name,
    required this.first_name,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      first_name: json['first_name'],
      last_name: json['last_name'],
      password: json['password'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': first_name,
      'last_name': last_name,
      'password': password,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
