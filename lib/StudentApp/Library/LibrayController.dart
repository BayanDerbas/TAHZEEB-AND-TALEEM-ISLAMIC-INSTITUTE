//
// import 'package:dio/dio.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// import 'LibraryModel.dart';
//
// class LibraryController extends GetxController {
//   var isLoading = true.obs;
//   var books = <LibraryItem>[].obs;
//   var documents = <LibraryItem>[].obs;
//   var searchBooks = <LibraryItem>[].obs; // قائمة الكتب بعد البحث
//   var searchDocuments = <LibraryItem>[].obs; // قائمة الملفات بعد البحث
//
//   @override
//   void onInit() {
//     fetchLibraryItems();
//     super.onInit();
//   }
//
//   void fetchLibraryItems() async {
//     try {
//       var response = await http.get(Uri.parse('http://127.0.0.1:8000/api/auth/student/student_showFiles'));
//
//       if (response.statusCode == 200) {
//         var jsonData = json.decode(response.body) as List;
//         var libraryItems = jsonData.map((item) => LibraryItem.fromJson(item)).toList();
//
//         books.assignAll(libraryItems.where((item) => item.type == 'book').toList());
//         documents.assignAll(libraryItems.where((item) => item.type == 'document').toList());
//
//         searchBooks.assignAll(books);
//         searchDocuments.assignAll(documents);
//       } else {
//         // handle error
//         print(response.reasonPhrase);
//       }
//     } finally {
//       isLoading(false);
//     }
//   }
//
//   void searchLibraryItems(String query) {
//     if (query.isEmpty) {
//       searchBooks.assignAll(books);
//       searchDocuments.assignAll(documents);
//     } else {
//       searchBooks.assignAll(books.where((book) => book.title.contains(query)).toList());
//       searchDocuments.assignAll(documents.where((document) => document.title.contains(query)).toList());
//     }
//   }
//
//   Future<void> downloadFile(String url, String fileName) async {
//     try {
//       Dio dio = Dio();
//       await dio.download(url, fileName);
//       // يمكنك إضافة منبه أو رسالة تفيد بنجاح تحميل الملف هنا
//     } catch (e) {
//       // التعامل مع الأخطاء
//       print('Error downloading file: $e');
//     }
//   }
// }
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'LibraryModel.dart';

class LibraryController extends GetxController {
  var isLoading = true.obs;
  var books = <LibraryItem>[].obs;
  var documents = <LibraryItem>[].obs;
  var searchBooks = <LibraryItem>[].obs; // قائمة الكتب بعد البحث
  var searchDocuments = <LibraryItem>[].obs; // قائمة الملفات بعد البحث

  @override
  void onInit() {
    fetchIdsFromPrefs();
    fetchLibraryItems();
    super.onInit();
  }
  Future<Map<String, int?>> fetchIdsFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userData = prefs.getString('user_data');

    int? classroomId;
    if (userData != null) {
      try {
        var userJson = json.decode(userData);
        classroomId = userJson['user']['classroom_id'] as int?;
        print("Classroom ID: $classroomId");
      } catch (e) {
        print("Error parsing user data: $e");
      }
    } else {
      print("User data not found in SharedPreferences.");
    }
    return {'classroom_id': classroomId};
  }


  void fetchLibraryItems() async {



    var ids = await fetchIdsFromPrefs();
    int? classroomId = ids['classroom_id'];

    if (classroomId == null) {
      print("Classroom ID not found in SharedPreferences.");
      return;
    }

    var headers = {
      'Accept': 'application/json',
    };

    try {
      var response = await http.get(
          Uri.parse('http://127.0.0.1:8000/api/auth/student/student_showFiles?classroom_id=$classroomId'),
          headers: headers
      );

      print("Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body) as List;
        var libraryItems = jsonData.map((item) => LibraryItem.fromJson(item)).toList();

        books.assignAll(libraryItems.where((item) => item.type == 'book').toList());
        documents.assignAll(libraryItems.where((item) => item.type == 'document').toList());

        searchBooks.assignAll(books);
        searchDocuments.assignAll(documents);
      } else {
        print('Failed to load library items: ${response.reasonPhrase}');
        Get.snackbar('Error', 'Failed to load library items', snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      print('Error fetching library items: $e');
      Get.snackbar('Error', 'An error occurred while fetching library items', snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
    }
  }

  void searchLibraryItems(String query) {
    if (query.isEmpty) {
      searchBooks.assignAll(books);
      searchDocuments.assignAll(documents);
    } else {
      searchBooks.assignAll(books.where((book) => book.title.contains(query)).toList());
      searchDocuments.assignAll(documents.where((document) => document.title.contains(query)).toList());
    }
  }

  // Future<void> downloadFile(String url, String fileName) async {
  //   try {
  //     final baseUrl = 'http://127.0.0.1:8000'; // استخدم المضيف الصحيح هنا
  //     final fullUrl = url.startsWith('http') ? url : '$baseUrl/$url';
  //
  //     print('Downloading from: $fullUrl'); // تأكد من أن الـ URL صحيح
  //
  //     var headers = {
  //       'Accept': 'application/json',
  //       'Content-Type': 'application/json'
  //     };
  //
  //     var request = http.Request('GET', Uri.parse("http://127.0.0.1:8000/api/auth/student/student_downloadPDF?id=6"));
  //     request.headers.addAll(headers);
  //
  //     http.StreamedResponse response = await request.send();
  //
  //     if (response.statusCode == 200) {
  //       // تحويل الـ stream إلى بيانات بايت
  //       var bytes = await response.stream.toBytes();
  //
  //       // تحديد المسار لحفظ الملف
  //       final file = File('/storage/emulated/0/Download/$fileName');
  //
  //       // كتابة البيانات إلى الملف
  //       await file.writeAsBytes(bytes);
  //
  //       // يمكنك إضافة منبه أو رسالة تفيد بنجاح تحميل الملف هنا
  //       Get.snackbar('Success', 'File downloaded successfully', snackPosition: SnackPosition.BOTTOM);
  //     } else {
  //       // التعامل مع الأخطاء
  //       print('Error downloading file: ${response.reasonPhrase}');
  //       Get.snackbar('Error', 'Failed to download file', snackPosition: SnackPosition.BOTTOM);
  //     }
  //   } catch (e) {
  //     // التعامل مع الأخطاء
  //     print('Error downloading file: $e');
  //     Get.snackbar('Error', 'Failed to download file', snackPosition: SnackPosition.BOTTOM);
  //   }
  // }
  Future<void> downloadFile(int fileId, String fileName) async {
    try {
      final url = 'http://127.0.0.1:8000/api/auth/student/student_downloadPDF?id=$fileId';

      print('Downloading from: $url'); // تأكد من أن الـ URL صحيح

      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      };

      var request = http.Request('GET', Uri.parse(url));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        // تحويل الـ stream إلى بيانات بايت
        var bytes = await response.stream.toBytes();

        // تحديد المسار لحفظ الملف
        final file = File('/storage/emulated/0/Download/$fileName');

        // كتابة البيانات إلى الملف
        await file.writeAsBytes(bytes);

        // يمكنك إضافة منبه أو رسالة تفيد بنجاح تحميل الملف هنا
        Get.snackbar('Success', 'File downloaded successfully', snackPosition: SnackPosition.BOTTOM);
      } else {
        // التعامل مع الأخطاء
        print('Error downloading file: ${response.reasonPhrase}');
        Get.snackbar('Error', 'Failed to download file', snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      // التعامل مع الأخطاء
      print('Error downloading file: $e');
      Get.snackbar('Error', 'Failed to download file', snackPosition: SnackPosition.BOTTOM);
    }
  }

}
