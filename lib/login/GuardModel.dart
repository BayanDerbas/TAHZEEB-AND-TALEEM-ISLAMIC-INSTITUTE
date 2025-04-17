// lib/models/guard_model.dart
class GuardModel {
  final String id;
  final String name;

  GuardModel({required this.id, required this.name});

  factory GuardModel.fromJson(Map<String, dynamic> json) {
    return GuardModel(
      id: json['id'],
      name: json['name'],
    );
  }
}
