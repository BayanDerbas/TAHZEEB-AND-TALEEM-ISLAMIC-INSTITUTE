// import 'dart:convert';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'AdviserModel.dart';
// import 'MentorModel.dart';
// import 'ParentModel.dart';
// import 'StudentModel.dart';
// import 'TeacherModel.dart';
//
//
// class LoginController extends GetxController {
//   var isLoading = false.obs;
//   var user = Rx<dynamic>(null); // نوع المستخدم يمكن أن يكون StudentModel أو TeacherModel أو غيره
//
//   @override
//   void onInit() {
//     super.onInit();
//   }
//   Future<void> loginTeacher(String name, String password) async {
//     isLoading.value = true;
//     var headers = {'Accept': 'application/json', 'Content-Type': 'application/json'};
//     var url = 'http://127.0.0.1:8000/api/auth/teacher/login?name=$name&password=$password';
//
//     try {
//       final response = await http.post(Uri.parse(url), headers: headers);
//       if (response.statusCode == 200) {
//         var jsonResponse = json.decode(response.body);
//         user.value = TeacherModel.fromJson(jsonResponse);
//         Get.snackbar('Success', 'Login successful');
//       } else {
//         Get.snackbar('Error', 'Failed to login');
//         print("5555555555555555555555555555555555 ${response.statusCode}  ${response.body}");
//
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'An error occurred');
//       print("#3333333333333333333333333 $e");
//
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   Future<void> loginStudent(String name, String password) async {
//     isLoading.value = true;
//     var headers = {'Accept': 'application/json', 'Content-Type': 'application/json'};
//     var url = 'http://127.0.0.1:8000/api/auth/student/login?name=$name&password=$password';
//
//     try {
//       final response = await http.post(Uri.parse(url), headers: headers);
//       if (response.statusCode == 200) {
//         var jsonResponse = json.decode(response.body);
//         user.value = StudentModel.fromJson(jsonResponse);
//         Get.snackbar('Success', 'Login successful');
//       } else {
//         Get.snackbar('Error', 'Failed to login');
//         print("5555555555555555555555555555555555 ${response.statusCode}  ${response.body}");
//
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'An error occurred');
//       print("#3333333333333333333333333 $e");
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   Future<void> loginParent(String name, String password) async {
//     isLoading.value = true;
//     var headers = {'Accept': 'application/json', 'Content-Type': 'application/json'};
//     var url = 'http://127.0.0.1:8000/api/auth/parent/login?name=$name&password=$password';
//
//     try {
//       final response = await http.post(Uri.parse(url), headers: headers);
//       if (response.statusCode == 200) {
//         var jsonResponse = json.decode(response.body);
//         user.value = ParentModel.fromJson(jsonResponse);
//         Get.snackbar('Success', 'Login successful');
//       } else {
//         Get.snackbar('Error', 'Failed to login');
//         print("5555555555555555555555555555555555 ${response.statusCode}  ${response.body}");
//
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'An error occurred');
//       print("#3333333333333333333333333 $e");
//
//     } finally {
//       isLoading.value = false;
//     }
//   }
//   Future<void> loginAdviser(String name, String password) async {
//     isLoading.value = true;
//     var headers = {'Accept': 'application/json', 'Content-Type': 'application/json'};
//     var url = 'http://127.0.0.1:8000/api/auth/adviser/login?name=$name&password=$password';
//
//     try {
//       final response = await http.post(Uri.parse(url), headers: headers);
//       if (response.statusCode == 200) {
//         var jsonResponse = json.decode(response.body);
//         user.value = AdvisorModel.fromJson(jsonResponse);
//         Get.snackbar('Success', 'Login successful');
//       } else {
//         Get.snackbar('Error', 'Failed to login');
//         print("5555555555555555555555555555555555 ${response.statusCode}  ${response.body}");
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'An error occurred');
//       print("#3333333333333333333333333 $e");
//
//     } finally {
//       isLoading.value = false;
//     }
//   }
//   Future<void> loginMentor(String name, String password) async {
//     isLoading.value = true;
//     var headers = {'Accept': 'application/json', 'Content-Type': 'application/json'};
//     var url = 'http://127.0.0.1:8000/api/auth/monitor/login?name=$name&password=$password';
//
//     try {
//       final response = await http.post(Uri.parse(url), headers: headers);
//       if (response.statusCode == 200) {
//         var jsonResponse = json.decode(response.body);
//         user.value = MentorModel.fromJson(jsonResponse);
//         Get.snackbar('Success', 'Login successful');
//       } else {
//         Get.snackbar('Error', 'Failed to login');
//         print("5555555555555555555555555555555555 ${response.statusCode}  ${response.body}");
//
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'An error occurred');
//       print("#3333333333333333333333333 $e");
//
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//
// }
//
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'AdviserModel.dart';
import 'MentorModel.dart';
import 'ParentModel.dart';
import 'StudentModel.dart';
import 'TeacherModel.dart';

class LoginnnnnController extends GetxController {
  var isLoading = false.obs;
  var user = Rx<dynamic>(null); // نوع المستخدم يمكن أن يكون StudentModel أو TeacherModel أو غيره

  @override
  void onInit() {
    loadUserData(); // تحميل بيانات المستخدم عند بدء التطبيق
    super.onInit();

  }

  Future<void> loginTeacher(String firstname,String lastname, String password) async {
    isLoading.value = true;
    var headers = {'Accept': 'application/json', 'Content-Type': 'application/json'};
    var url = 'http://127.0.0.1:8000/api/auth/teacher/login?first name=$firstname&last name=$lastname&password=$password';

    try {
      final response = await http.post(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        user.value = TeacherModel.fromJson(jsonResponse);

        // حفظ بيانات تسجيل الدخول في SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_type', 'teacher');
        await prefs.setString('user_data', response.body);
        Get.offAllNamed('/homeTeacher_screen');

        Get.snackbar('Success', 'Login successful');
      } else {
        Get.snackbar('Error', 'Failed to login');
        print("Error ${response.statusCode} ${response.body}");
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred');
      print("Exception $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loginStudent(String firstname,String lastname, String password) async {
    isLoading.value = true;
    var headers = {'Accept': 'application/json', 'Content-Type': 'application/json'};
    var url = 'http://127.0.0.1:8000/api/auth/student/login?first name=$firstname&last name=$lastname&password=$password';

    try {
      final response = await http.post(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        user.value = StudentModel.fromJson(jsonResponse);

        // حفظ بيانات تسجيل الدخول في SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_type', 'student');
        await prefs.setString('user_data', response.body);
        Get.offAllNamed('/homeStudent');

        Get.snackbar('Success', 'Login successful');
      } else {
        Get.snackbar('Error', 'Failed to login');
        print("Error ${response.statusCode} ${response.body}");
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred');
      print("Exception $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loginParent(String firstname,String lastname, String password) async {
    isLoading.value = true;
    var headers = {'Accept': 'application/json', 'Content-Type': 'application/json'};
    var url = 'http://127.0.0.1:8000/api/auth/parent/login?first name=$firstname&last name=$lastname&password=$password';

    try {
      final response = await http.post(Uri.parse(url), headers: headers);
      print("00000000000000000000${response.statusCode}");
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        user.value = ParentModel.fromJson(jsonResponse);

        // حفظ بيانات تسجيل الدخول في SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_type', 'parent');
        await prefs.setString('user_data', response.body);
        Get.offAllNamed('/homeParent');

        Get.snackbar('Success', 'Login successful');
      } else {
        Get.snackbar('Error', 'Failed to login');
        print("Error ${response.statusCode} ${response.body}");
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred');
      print("Exception $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loginAdviser(String firstname,String lastname, String password) async {
    isLoading.value = true;
    var headers = {'Accept': 'application/json', 'Content-Type': 'application/json'};
    var url = 'http://127.0.0.1:8000/api/auth/adviser/login?first name=$firstname&last name=$lastname&password=$password';

    try {
      final response = await http.post(Uri.parse(url), headers: headers);
      print("ssssssssssssssssssssssssss${response.statusCode}");
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        user.value = AdvisorModel.fromJson(jsonResponse);
        print(user.value);
        // حفظ بيانات تسجيل الدخول في SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_type', 'adviser');
        await prefs.setString('user_data', response.body);
        Get.offAllNamed('/AdviserConsultScreen');

        Get.snackbar('Success', 'Login successful');
      } else {
        Get.snackbar('Error', 'Failed to login');
        print("Error ${response.statusCode} ${response.body}");
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred');
      print("Exception $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loginMentor(String firstname,String lastname, String password) async {
    isLoading.value = true;
    var headers = {'Accept': 'application/json', 'Content-Type': 'application/json'};
    var url = 'http://127.0.0.1:8000/api/auth/monitor/login?first_name=$firstname&password=$password&last_name=$lastname';

    try {
      final response = await http.post(Uri.parse(url), headers: headers);
      print("gggggggggggggggggggggggggggggg${response.statusCode}");
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        user.value = MentorModel.fromJson(jsonResponse);

        // حفظ بيانات تسجيل الدخول في SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_type', 'mentor');
        await prefs.setString('user_data', response.body);
        Get.offAllNamed('/MonitorHome');

        Get.snackbar('Success', 'Login successful');
      } else {
        Get.snackbar('Error', 'Failed to login');
        print("Error ${response.statusCode} ${response.body}");
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred');
      print("Exception $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userType = prefs.getString('user_type');
    String? userData = prefs.getString('user_data');

    if (userType != null && userData != null) {
      if (userType == 'teacher') {
        user.value = TeacherModel.fromJson(json.decode(userData));
      } else if (userType == 'student') {
        user.value = StudentModel.fromJson(json.decode(userData));
      } else if (userType == 'parent') {
        user.value = ParentModel.fromJson(json.decode(userData));
      } else if (userType == 'adviser') {
        user.value = AdvisorModel.fromJson(json.decode(userData));
      } else if (userType == 'mentor') {
        user.value = MentorModel.fromJson(json.decode(userData));
      }
    }
  }

  Future<void> logout() async {
    isLoading.value = true;

    try {
      // مسح بيانات تسجيل الدخول من SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('user_type');
      await prefs.remove('user_data');

      // إعادة تعيين حالة المستخدم
      user.value = null;
      Get.snackbar('Success', 'Logout successful');
    } catch (e) {
      Get.snackbar('Error', 'An error occurred during logout');
      print("Exception $e");
    } finally {
      isLoading.value = false;
    }
  }

}
