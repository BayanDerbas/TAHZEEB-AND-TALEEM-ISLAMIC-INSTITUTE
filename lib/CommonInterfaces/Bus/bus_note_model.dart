import 'package:intl/intl.dart';

class BusNote {
  final String transport;
  final String parent;
  final String status;
  final String note;
  final String date;

  BusNote({
    required this.transport,
    required this.parent,
    required this.status,
    required this.note,
    required this.date,
  });

  factory BusNote.fromJson(Map<String, dynamic> json) {
    // Assuming the date string in the JSON is in a format that DateTime.parse can handle.
    DateTime dateTime = DateTime.parse(json['date']);

    // Formatting the date to only include the date part (e.g., yyyy-MM-dd).
    String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);

    return BusNote(
      transport: json['transport'],
      parent: json['parent'],
      status: json['status'],
      note: json['note'],
      date: formattedDate,
    );
  }
}
