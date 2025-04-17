import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sprint1/StudentApp/SendConsult/sendConsult_screen.dart';
import 'package:sprint1/StudentApp/sendQuestion/sendQuestion_screen.dart';
import 'AdviserApp/Adviser_Consults/Adviser_consults_screen.dart';
import 'AdviserApp/ConsultResponse/consultAnswer_screen.dart';
import 'CommonInterfaces/Bus/BusNew.dart';
import 'CommonInterfaces/Homeworks/Requirements_Homeworks.dart';
import 'CommonInterfaces/StudentAttend/StudentAttendScreen.dart';
import 'CommonInterfaces/StudentBehavior/StudentBehaviorScreen.dart';
import 'CommonInterfaces/student_degrees/student_degrees/student_degrees_screen.dart';
import 'CommonInterfaces/student_evaluation/student_evaluation/student_evaluation_screen.dart';
import 'CommonInterfaces/student_weektable (1)/student_weektable/student_weektable_screen.dart';
import 'MentorApp/monitor_home/monitor_home.dart';
import 'ParentApp/HomeParent/homeParent_screen.dart';
import 'ParentApp/ProfileStudentForParent/profileStudent_Parent.dart';
import 'ParentApp/SendNote/sendNote_screen.dart';
import 'MentorApp/ScannerQR/QRScanner.dart';
import 'StudentApp/Library/Library.dart';
import 'StudentApp/Plans/Allplans.dart';
import 'StudentApp/Plans/tasks/TaskModel.dart';
import 'StudentApp/Plans/tasks/tasks_screen.dart';
import 'StudentApp/ProfileStudent/profileStudent_screen.dart';
import 'StudentApp/ShowQuestion/StudentShowQuestion_screen.dart';
import 'StudentApp/StudentConsult/StudentConsultScreen.dart';
import 'StudentApp/StudentShowConsult/StudentShowConsult_screen.dart';
import 'StudentApp/Student_question/student_questions_screen.dart';
import 'StudentApp/activity/activity_screen.dart';
import 'StudentApp/firsts_and_ranks/firsts_and_ranks_screen.dart';
import 'StudentApp/homeStudent/homeStudent_screen.dart';
import 'TeacherApp/CreateQR/CreateQR.dart';
import 'TeacherApp/LibraryTeacher/LibraryTeacher.dart';
import 'TeacherApp/Preparing a lesson/Allplans.dart';
import 'TeacherApp/Preparing a lesson/draw/DrawScreen.dart';
import 'TeacherApp/QuestionReply_screen/QuestionReply_screen.dart';
import 'TeacherApp/SendHomeworks/SendHomeworks.dart';
import 'TeacherApp/Teacher_students_questions/Teacher_questions_screen.dart';
import 'TeacherApp/UploadFile/UploadFile.dart';
import 'TeacherApp/homeTeacher_screen.dart';
import 'TeacherApp/teacher_weektable/teacher_weektable/teacher_weektable_screen.dart';
import 'login/login_screen.dart';
import 'package:path_provider/path_provider.dart' as path_provider;



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 // await Firebase.initializeApp();  // تهيئة Firebase
  await initializeDateFormatting('ar', null);
  await Hive.initFlutter();
  final appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();
  await Hive.openBox('drawingsBox');
  await Hive.openBox('taskBox'); // فتح صندوق للمهام
  await Hive.openBox('tasksBox');
  await Hive.openBox('checklistBox');
  Hive.init(appDocumentDirectory.path);

  // // تسجيل Adapter
  // Hive.registerAdapter(TaskAdapter());
  // Hive.registerAdapter(TaskListAdapter());
  await Hive.openBox<TaskList>('taskLists');
  // تحميل بيانات المستخدم من SharedPreferences
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? userType = prefs.getString('user_type');

  runApp(MyApp(initialScreen: userType != null ? _getHomeScreen(userType) : const login_screen()));

}
Widget _getHomeScreen(String userType) {
  switch (userType) {
    case 'student':
      return const homestudent_screen();
    case 'parent':
      return const HomeParentScreen();
    case 'teacher':
      return const homeTeacher_screen();
    case 'adviser':
      return const AdviserConsultScreen();
    case 'mentor':
      return const MonitorHome();
    default:
      return const login_screen(); // افتراضياً إعادة المستخدم لشاشة تسجيل الدخول
  }
}
class MyApp extends StatelessWidget {
  final Widget initialScreen;

  const MyApp({super.key, required this.initialScreen});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: const TextTheme(bodyMedium: TextStyle()),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child ?? const SizedBox.shrink(), // التأكد من عدم استخدام child! بدون تحقق
        );
      },
      home: initialScreen, // افترض أن LoginScreen هي صفحة تسجيل الدخول
      debugShowCheckedModeBanner: false,
     // initialRoute: '/homeParent',
      getPages: [
        GetPage(name: '/login', page: () => const login_screen()),
        GetPage(name: '/homeStudent', page: () => const homestudent_screen()), // تأكد من أن HomeScreen موجودة ومعدة بشكل صحيح
        GetPage(name: '/homeParent', page: () => const HomeParentScreen()), // تأكد من أن HomeScreen موجودة ومعدة بشكل صحيح
        GetPage(name: '/profile', page: () => const profileStudent_screen()),
        GetPage(name: '/sendNote', page: () => const SendNoteScreen()),
        GetPage(name: '/sendConsult', page: () => const sendConsult_screen()),
        GetPage(name: '/Attend', page: () => const Attend()),
        GetPage(name: '/RequirementHomeworks', page: () => RequirementHomeworks()),
        GetPage(name: '/Behavior', page: () => const Behavior()),
        GetPage(name: '/ActivityScreen', page: () => const ActivityScreen()),
        GetPage(name: '/Bus', page: () => Bus()),
        GetPage(name: '/Library', page: () => const Library()),
        GetPage(name: '/DrawingApp', page: () => const Plans()),
        GetPage(name: '/TasksScreen', page: () => const TasksScreen()),
        GetPage(name: '/FirstsAndRanksScreen', page: () => const FirstsAndRanksScreen()),
        GetPage(name: '/homeTeacher_screen', page: () => const homeTeacher_screen()),
        GetPage(name: '/DrawingTeacher', page: () => const DrawingTeacher()),
        GetPage(name: '/PlansTeacher', page: () => const PlansTeacher()),
        GetPage(name: '/QRCodePage', page: () =>  QRCodePage()),
        GetPage(name: '/UploadFile', page: () => const UploadFile()),
        GetPage(name: '/SendHomeworks', page: () => const SendHomeworks()),
        GetPage(name: '/BarcodeScanPage', page: () =>  BarcodeScanPage()),
        GetPage(name: '/StudentEvaluationScreen', page: () => const StudentEvaluationScreen()),
        GetPage(name: '/StudentWeektableScreen', page: () => const StudentWeektableScreen()),
        GetPage(name: '/consultAnswer_screen', page: () => const consultAnswer_screen()),
        GetPage(name: '/profileStudent_Parent', page: () => const profileStudent_Parent()),
        GetPage(name: '/TeacherWeektableScreen', page: () => const TeacherWeektableScreen()),
        GetPage(name: '/QRCodePage', page: () =>  QRCodePage()),
        GetPage(name: '/LibraryTeacher', page: () => const LibraryTeacher()),
        GetPage(name: '/TeacherQuestionScreen', page: () => const TeacherQuestionScreen()),
        GetPage(name: '/StudentDegreesScreen', page: () => const StudentDegreesScreen()),
        GetPage(name: '/StudentQuestionScreen', page: () => const StudentQuestionScreen()),
        GetPage(name: '/AdviserConsultScreen', page: () => const AdviserConsultScreen()),
        GetPage(name: '/QuestionAnswer_screen', page: () => const QuestionAnswer_screen()),
        GetPage(name: '/StudentConsultScreen', page: () => const StudentConsultScreen()),
        GetPage(name: '/StudentShowQuestion_screen', page: () => const StudentShowQuestion_screen()),
        GetPage(name: '/StudentShowConsult_screen', page: () => const StudentShowConsult_screen()),
        GetPage(name: '/sendConsult_screen', page: () => const sendConsult_screen()),
        GetPage(name: '/sendQuestion_screen', page: () => const sendQuestion_screen()),
        GetPage(name: '/sendQuestion_screen', page: () => const sendQuestion_screen()),
        GetPage(name: '/MonitorHome', page: () => const MonitorHome()),
        GetPage(name: '/BarcodeScanPage', page: () =>  BarcodeScanPage()),

      ],
    );
  }
}

