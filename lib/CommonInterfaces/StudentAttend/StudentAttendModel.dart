    import 'package:intl/intl.dart';

    class Attendance {
      final int id;
      final String attendanceStatus;
      final int studentId;
      final int classroomId;
      final int departmentId;
      final String attendanceDate;
      final String? absentReason;
      final String createdAt;
      final String updatedAt;
      bool isJustified; // Define this property

      Attendance({
        required this.id,
        required this.attendanceStatus,
        required this.studentId,
        required this.classroomId,
        required this.departmentId,
        required this.attendanceDate,
        this.absentReason,
        required this.createdAt,
        required this.updatedAt,
        required this.isJustified, // Include it in the constructor
      });


      factory Attendance.fromJson(Map<String, dynamic> json) {
        return Attendance(
          id: json['id'] ?? 0, // Default value if null
          attendanceStatus: json['attendance_status'] ?? '',
          studentId: json['student_id'] ?? 0,
          classroomId: json['classroom_id'] ?? 0,
          departmentId: json['department_id'] ?? 0,
          attendanceDate: json['attendance_date'] ?? '',
          absentReason: json['absent_reason']?? '',
          createdAt: json['created_at'] ?? '',
          updatedAt: json['updated_at'] ?? '',
          isJustified: json['is_justified'] ?? false, // Use default value for boolean
        );
      }



      String getDayName() {
        DateTime date = DateTime.parse(attendanceDate);
        String dayName = DateFormat('EEEE').format(date); // EEEE for full day name
        return dayName;
      }

      String getDayNameInArabic() {
        DateTime date = DateTime.parse(attendanceDate);
        DateFormat arabicFormat = DateFormat.EEEE('ar');
        String dayName = arabicFormat.format(date); // EEEE for full day name
        print(dayName);
        return dayName;
      }
  }



    class Summary {
      final int present;
      final int late;
      final Absent absent;

      Summary({
        required this.present,
        required this.late,
        required this.absent,
      });

      factory Summary.fromJson(Map<String, dynamic> json) {
        return Summary(
          present: json['حاضر'] ?? 0, // Default value if null
          late: json['تأخر'] ?? 0,
          absent: Absent.fromJson(json['غياب'] ?? {}),
        );
      }
    }

      class Absent {
      final int justified;
      final int unjustified;

      Absent({
        required this.justified,
        required this.unjustified,
      });

      factory Absent.fromJson(Map<String, dynamic> json) {
        return Absent(
          justified: json['مبرر'] ?? 0, // Default value if null
          unjustified: json['غير مبرر'] ?? 0,
        );
      }

      }
