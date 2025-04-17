class Lesson {
  final String day;
  final String startTime;
  final String endTime;
  final String classroom;

  Lesson({
    required this.day,
    required this.startTime,
    required this.endTime,
    required this.classroom,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      day: json['day'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      classroom: json['classroom'],
    );
  }
}
