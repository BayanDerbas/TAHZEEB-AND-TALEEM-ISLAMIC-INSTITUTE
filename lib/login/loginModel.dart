// import 'AdviserModel.dart';
// import 'ParentModel.dart';
// import 'StudentModel.dart';
// import 'TeacherModel.dart';
//
// abstract class UserModel {
//   final String accessToken;
//   final String tokenType;
//   final int expiresIn;
//   final dynamic user;
//
//   UserModel({
//     required this.accessToken,
//     required this.tokenType,
//     required this.expiresIn,
//     this.user,
//   });
//
//   factory UserModel.fromJson(Map<String, dynamic> json, String type) {
//     switch (type) {
//       case 'StudentModel':
//         return StudentModel.fromJson(json);
//       case 'TeacherModel':
//         return TeacherModel.fromJson(json);
//       case 'ParentModel':
//         return ParentModel.fromJson(json);
//       case 'AdviserModel':
//         return AdviserModel.fromJson(json);
//       default:
//         throw Exception('Unknown user type');
//     }
//   }
// }