// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_navigation/get_navigation.dart';
//
// import '../color_.dart';
// import 'loginController.dart';
//
// class login_screen extends StatefulWidget {
//   @override
//   State<login_screen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<login_screen> {
//   final List<String> items = [
//     'طالب',
//     'طالبة',
//     'ولي الأمر',
//     'مرشد',
//     'معلم',
//     'موجه',
//   ];
//   String? selectedItem;
//   TextEditingController nameController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   final LoginnnnnController loginController = Get.put(LoginnnnnController());
//
//   // التعامل مع الاستجابة بعد محاولة تسجيل الدخول
//   void _handleLoginResponse() {
//     if (loginController.user.value != null) {
//       switch (selectedItem) {
//         case 'طالب':
//         case 'طالبة':
//           Get.offNamed('/homeStudent');
//           break;
//         case 'ولي الأمر':
//           Get.offNamed('/homeParent');
//           break;
//         case 'معلم':
//           Get.offNamed('/homeTeacher_screen');
//           break;
//         case 'موجه':
//           Get.offNamed('/HomeMentor');
//           break;
//         case 'مرشد':
//           Get.offNamed('/homeAdviser');
//           break;
//         default:
//           Get.snackbar('خطأ', 'نوع المستخدم غير معروف');
//       }
//     } else {
//       Get.snackbar('خطأ', 'فشل تسجيل الدخول'); // رسالة خطأ عند فشل تسجيل الدخول
//     }
//   }
//
//   @override
//   void dispose() {
//     nameController.dispose();
//     passwordController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           // الصورة العلوية
//           Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Image.asset("assets/12.png"),
//             ],
//           ),
//           SingleChildScrollView(
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: 200,
//                   child: Image.asset(
//                     "assets/14.png",
//                   ),
//                 ),
//                 SizedBox(height: 15),
//                 Container(
//                   width: 400,
//                   height: 60,
//                   padding: EdgeInsets.symmetric(horizontal: 12),
//                   margin: EdgeInsets.symmetric(horizontal: 10),
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.green),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: DropdownButton<String>(
//                     isExpanded: true,
//                     underline: SizedBox(),
//                     value: selectedItem,
//                     onChanged: (String? newValue) {
//                       setState(() {
//                         selectedItem = newValue;
//                       });
//                     },
//                     items: items.map((String item) {
//                       return DropdownMenuItem<String>(
//                         value: item,
//                         child: Text(item),
//                       );
//                     }).toList(),
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 7),
//                   child: TextFormField(
//                     controller: nameController,
//                     decoration: InputDecoration(
//                       suffixIcon: Icon(Icons.person, color: color_.gray),
//                       floatingLabelBehavior: FloatingLabelBehavior.always,
//                       labelText: 'الاسم',
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8.0),
//                         borderSide: BorderSide(color: color_.green),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8.0),
//                         borderSide: BorderSide(color: color_.green),
//                       ),
//                       labelStyle: TextStyle(
//                         color: color_.black,
//                         fontSize: 20,
//                       ),
//                     ),
//                     style: TextStyle(
//                       color: color_.black,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 7),
//                   child: TextFormField(
//                     controller: passwordController,
//                     decoration: InputDecoration(
//                       suffixIcon: Icon(Icons.lock_outline_rounded, color: color_.gray),
//                       floatingLabelBehavior: FloatingLabelBehavior.always,
//                       labelText: 'الرقم',
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8.0),
//                         borderSide: BorderSide(color: color_.green),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8.0),
//                         borderSide: BorderSide(color: color_.green),
//                       ),
//                       labelStyle: TextStyle(
//                         color: color_.black,
//                         fontSize: 20,
//                       ),
//                     ),
//                     style: TextStyle(
//                       color: color_.black,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 25),
//                 Obx(
//                       () => ElevatedButton(
//                     onPressed: loginController.isLoading.value
//                         ? null // إذا كان التطبيق في حالة تحميل، لا يسمح بالنقر
//                         : () {
//                       if (selectedItem != null &&
//                           nameController.text.isNotEmpty &&
//                           passwordController.text.isNotEmpty) {
//                         // تحديد نوع المستخدم
//                         switch (selectedItem) {
//                           case 'طالب':
//                             loginController
//                                 .loginStudent(
//                                 nameController.text, passwordController.text)
//                                 .then((_) => _handleLoginResponse());
//                             break;
//                           case 'معلم':
//                             loginController
//                                 .loginTeacher(
//                                 nameController.text, passwordController.text)
//                                 .then((_) => _handleLoginResponse());
//                             break;
//                           case 'ولي الأمر':
//                             loginController
//                                 .loginParent(
//                                 nameController.text, passwordController.text)
//                                 .then((_) => _handleLoginResponse());
//                             break;
//                           case 'موجه':
//                             loginController
//                                 .loginMentor(
//                                 nameController.text, passwordController.text)
//                                 .then((_) => _handleLoginResponse());
//                             break;
//                           case 'مرشد':
//                             loginController
//                                 .loginAdviser(
//                                 nameController.text, passwordController.text)
//                                 .then((_) => _handleLoginResponse());
//                             break;
//                           default:
//                             Get.snackbar('خطأ', 'يرجى اختيار نوع المستخدم');
//                         }
//                       } else {
//                         Get.snackbar('خطأ', 'يرجى ملء جميع الحقول');
//                       }
//                     },
//                     child: loginController.isLoading.value
//                         ? CircularProgressIndicator()
//                         : Text(
//                       "تسجيل الدخول",
//                       style: TextStyle(color: color_.black),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 15, horizontal: 155),
//                         backgroundColor: color_.yellow,
//                         shape: const RoundedRectangleBorder(
//                             borderRadius:
//                             BorderRadius.all(Radius.circular(20.0)))),
//                   ),
//                 ),
//                 SizedBox(height: 50),
//               ],
//             ),
//           ),
//           // الصورة السفلية
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               Image.asset("assets/13.png"),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../color_.dart';
import 'loginController.dart';

class login_screen extends StatefulWidget {
  const login_screen({super.key});

  @override
  State<login_screen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<login_screen> {
  final List<String> items = [
    'طالب',
    'طالبة',
    'ولي الأمر',
    'مرشد',
    'معلم',
    'موجه',
  ];
  String? selectedItem;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController(); // حقل الكنية الجديد
  TextEditingController passwordController = TextEditingController();
  final LoginnnnnController loginController = Get.put(LoginnnnnController());

  // التعامل مع الاستجابة بعد محاولة تسجيل الدخول
// التعامل مع الاستجابة بعد محاولة تسجيل الدخول
  void _handleLoginResponse() {
    if (loginController.user.value != null) {
      // تحقق من وجود المستخدم بنجاح
      switch (selectedItem) {
        case 'طالب':
        case 'طالبة':
          Get.offNamed('/homeStudent');
          break;
        case 'ولي الأمر':
          Get.offNamed('/homeParent');
          break;
        case 'معلم':
          Get.offNamed('/homeTeacher_screen');
          break;
        case 'موجه':
          Get.offNamed('/HomeMentor');
          break;
        case 'مرشد':
          Get.offNamed('/homeAdviser');
          break;
        default:
          Get.snackbar('خطأ', 'نوع المستخدم غير معروف');
      }
    } else {
      // عدم الانتقال إذا كان تسجيل الدخول فاشلاً
      Get.snackbar('خطأ', 'فشل تسجيل الدخول');
    }
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose(); // التخلص من حقل الكنية الجديد
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // الصورة العلوية
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset("assets/12.png"),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 200, child: Image.asset("assets/14.png")),
                  Container(
                    width: 400,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      underline: const SizedBox(),
                      value: selectedItem,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedItem = newValue;
                        });
                      },
                      items: items.map((String item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 7),
                    child: TextFormField(
                      controller: firstNameController,
                      decoration: InputDecoration(
                        suffixIcon: const Icon(Icons.person, color: color_.gray),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: 'الاسم',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(color: color_.green),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(color: color_.green),
                        ),
                        labelStyle: const TextStyle(
                          color: color_.black,
                          fontSize: 20,
                        ),
                      ),
                      style: const TextStyle(
                        color: color_.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 7),
                    child: TextFormField(
                      controller: lastNameController, // حقل الكنية الجديد
                      decoration: InputDecoration(
                        suffixIcon: const Icon(Icons.person, color: color_.gray),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: 'الكنية',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(color: color_.green),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(color: color_.green),
                        ),
                        labelStyle: const TextStyle(
                          color: color_.black,
                          fontSize: 20,
                        ),
                      ),
                      style: const TextStyle(
                        color: color_.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 7),
                    child: TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        suffixIcon: const Icon(Icons.lock_outline_rounded, color: color_.gray),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: 'الرقم',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(color: color_.green),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(color: color_.green),
                        ),
                        labelStyle: const TextStyle(
                          color: color_.black,
                          fontSize: 20,
                        ),
                      ),
                      style: const TextStyle(
                        color: color_.black,
                      ),
                    ),
                  ),
                 const SizedBox(height: 5),
                  Obx(
                        () => ElevatedButton(
                      onPressed: loginController.isLoading.value
                          ? null // إذا كان التطبيق في حالة تحميل، لا يسمح بالنقر
                          : () {
                        if (selectedItem != null &&
                            firstNameController.text.isNotEmpty &&
                            lastNameController.text.isNotEmpty && // التحقق من الكنية أيضًا
                            passwordController.text.isNotEmpty) {
                          // تحديد نوع المستخدم
                          switch (selectedItem) {
                            case 'طالب':
                            case 'طالبة':

                              loginController
                                  .loginStudent(
                                  firstNameController.text , lastNameController.text, passwordController.text);
                                  //.then((_) => _handleLoginResponse());
                              break;
                            case 'معلم':
                              loginController
                                  .loginTeacher(
                                  firstNameController.text , lastNameController.text, passwordController.text);
                                  //.then((_) => _handleLoginResponse());
                              break;
                            case 'ولي الأمر':
                              loginController
                                  .loginParent(
                                  firstNameController.text , lastNameController.text, passwordController.text);
                                  //.then((_) => _handleLoginResponse());
                              break;
                            case 'موجه':
                              loginController
                                  .loginMentor(
                                  firstNameController.text , lastNameController.text, passwordController.text);
                                 // .then((_) => _handleLoginResponse());
                              break;
                            case 'مرشد':
                              loginController
                                  .loginAdviser(
                                  firstNameController.text , lastNameController.text, passwordController.text);
                                //  .then((_) => _handleLoginResponse());
                              break;
                            default:
                              Get.snackbar('خطأ', 'يرجى اختيار نوع المستخدم');
                          }
                        } else {
                          Get.snackbar('خطأ', 'يرجى ملء جميع الحقول');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 155),
                          backgroundColor: color_.yellow,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(20.0)))),
                      child: loginController.isLoading.value
                          ? const CircularProgressIndicator()
                          : const Text(
                        "تسجيل الدخول",
                        style: TextStyle(color: color_.black),
                      ),
                    ),
                  ),
                 const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image.asset("assets/13.png"),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // الصورة السفلية

        ],
      ),
    );
  }
}

