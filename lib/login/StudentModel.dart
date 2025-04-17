class StudentModel {
  final String accessToken;
  final String tokenType;
  final int expiresIn;
  final dynamic user; // استخدم النوع المناسب بناءً على هيكل البيانات

  StudentModel({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
    this.user,
  });

  // تحويل JSON إلى كائن Dart
  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      accessToken: json['access_token'] as String,
      tokenType: json['token_type'] as String,
      expiresIn: json['expires_in'] as int,
      user: json['user'], // تأكد من نوع البيانات الخاصة بالمستخدم هنا
    );
  }

  // تحويل كائن Dart إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'token_type': tokenType,
      'expires_in': expiresIn,
      'user': user, // تأكد من أن user يمكن تحويله إلى JSON
    };
  }
}