class NoteModel {
  final int parentId;
  final int adminId;
  final String note;
  final DateTime sentAt;
  final DateTime updatedAt;
  final DateTime createdAt;
  final int id;

  NoteModel({
    required this.parentId,
    required this.adminId,
    required this.note,
    required this.sentAt,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      parentId: json['parent_id'],
      adminId: json['admin_id'],
      note: json['note'],
      sentAt: DateTime.parse(json['sent_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      createdAt: DateTime.parse(json['created_at']),
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'parent_id': parentId,
      'admin_id': adminId,
      'note': note,
      'sent_at': sentAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'id': id,
    };
  }
}
