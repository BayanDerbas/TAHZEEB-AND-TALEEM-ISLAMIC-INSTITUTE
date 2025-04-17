// library_item.dart
class LibraryItem {
  int id;
  String fileUrl;
  String title;
  int subjectId;
  int teacherId;
  int classroomId;
  String type;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  final String downloadUrl; // رابط تحميل الملف


  LibraryItem({
    required this.id,
    required this.fileUrl,
    required this.title,
    required this.subjectId,
    required this.teacherId,
    required this.classroomId,
    required this.type,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.downloadUrl,

  });

  factory LibraryItem.fromJson(Map<String, dynamic> json) {
    return LibraryItem(
      id: json['id'],
      fileUrl: json['file_url'],
      title: json['title'],
      subjectId: json['subject_id'],
      teacherId: json['teacher_id'],
      classroomId: json['classroom_id'],
      type: json['type'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      downloadUrl: json['file_url'], // تأكد من أن هذا المفتاح يتطابق مع JSON من الخادم

    );
  }
}
