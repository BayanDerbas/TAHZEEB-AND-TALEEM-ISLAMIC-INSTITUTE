// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../color_.dart';
//
// class homeParent_screen extends StatelessWidget {
//   const homeParent_screen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Container(
//             height: 200,
//             child: AppBar(
//               title: Text(
//                 "اسم الطالب",
//                 style: TextStyle(color: color_.white),
//               ),
//               backgroundColor: color_.green,
//               leading: IconButton(
//                 onPressed: () {
//                   Get.toNamed('/profileStudent');
//                 },
//                 icon: Icon(Icons.account_circle, size: 35, color: Colors.white),
//               ),
//               actions: [
//                 IconButton(
//                   onPressed: () {},
//                   icon:
//                       Icon(Icons.notifications, color: Colors.white, size: 30),
//                 ),
//                 IconButton(
//                   onPressed: () {},
//                   icon: Transform(
//                     alignment: Alignment.center,
//                     transform: Matrix4.rotationY(3.14159), // This rotates the icon by 180 degrees along the Y axis (pi radians)
//                     child: Icon(Icons.logout, color: Colors.white, size: 30),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 90, bottom: 175, left: 10, right: 10),
//             child: Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.05),
//                     spreadRadius: 1,
//                     blurRadius: 8,
//                     offset: Offset(0, 8), // Changes position of shadow to bottom only
//                   ),
//                 ],
//               ),
//               child: SizedBox(
//                 height: 600, // Set the desired height for the Card
//                 child: Card(
//                   elevation: 0, // Set card elevation to 0 to use custom shadow
//                   margin: EdgeInsets.fromLTRB(12, 0.1, 12, 0.1),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                   color: color_.white,
//                   child: Column(
//                     children: [
//                       Row(
//                         children: [
//                           GestureDetector(
//                             onTap: (){},
//                             child: Padding(
//                               padding: const EdgeInsets.only(right: 35,top: 15),
//                               child: Container(
//                                 height: 120,
//                                 width: 130,
//                                 decoration: BoxDecoration(
//                                   border: Border.all(color: color_.green, width: 3.2),
//                                   borderRadius: BorderRadius.circular(25),
//                                 ),
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Image.asset("assets/1.png", height: 65),
//                                     Text("دوام الطالب", textAlign: TextAlign.center),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(width: 20,),
//                           GestureDetector(
//                             onTap: (){},
//                             child: Padding(
//                               padding: const EdgeInsets.only(right:20,top: 15),
//                               child: Container(
//                                 height: 120,
//                                 width: 130,
//                                 decoration: BoxDecoration(
//                                   border: Border.all(color: color_.green, width: 3.2),
//                                   borderRadius: BorderRadius.circular(25),
//                                 ),
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Image.asset("assets/2.png", height: 65),
//                                     Text("درجات الطالب", textAlign: TextAlign.center),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                       SizedBox(height: 5,),
//                       Row(
//                         children: [
//                           GestureDetector(
//                             onTap: (){},
//                             child: Padding(
//                               padding: const EdgeInsets.only(right: 35,top: 25),
//                               child: Container(
//                                 height: 120,
//                                 width: 130,
//                                 decoration: BoxDecoration(
//                                   border: Border.all(color: color_.green, width: 3.2),
//                                   borderRadius: BorderRadius.circular(25),
//                                 ),
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Image.asset("assets/3.png", height: 65),
//                                     Text("المقررات الدراسية", textAlign: TextAlign.center),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(width: 20,),
//                           GestureDetector(
//                             onTap: (){},
//                             child: Padding(
//                               padding: const EdgeInsets.only(right:20,top: 25),
//                               child: Container(
//                                 height: 120,
//                                 width: 130,
//                                 decoration: BoxDecoration(
//                                   border: Border.all(color: color_.green, width: 3.2),
//                                   borderRadius: BorderRadius.circular(25),
//                                 ),
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Image.asset("assets/4.png", height: 65),
//                                     Text("تقييم الطالب", textAlign: TextAlign.center),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                       SizedBox(height: 5,),
//                       Row(
//                         children: [
//                           GestureDetector(
//                             onTap: (){},
//                             child: Padding(
//                               padding: const EdgeInsets.only(right: 35,top: 25),
//                               child: Container(
//                                 height: 120,
//                                 width: 130,
//                                 decoration: BoxDecoration(
//                                   border: Border.all(color: color_.green, width: 3.2),
//                                   borderRadius: BorderRadius.circular(25),
//                                 ),
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Image.asset("assets/5.png", height: 65),
//                                     Text("السلوك والملاحظات", textAlign: TextAlign.center),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(width: 20,),
//                         ],
//                       ),
//                       SizedBox(height: 3,),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           GestureDetector(
//                             onTap: (){},
//                             child: Padding(
//                               padding: const EdgeInsets.only(right: 8,top: 25),
//                               child: Container(
//                                 height: 120,
//                                 width: 130,
//                                 decoration: BoxDecoration(
//                                   border: Border.all(color: color_.green, width: 3.2),
//                                   borderRadius: BorderRadius.circular(25),
//                                 ),
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Image.asset("assets/11.png", height: 65),
//                                     Text("المواصلات", textAlign: TextAlign.center),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Positioned(
//             bottom: 100,
//             left: 100,
//             right: 100,
//             child: Container(
//               height: 50, // Adjust the height as needed
//               decoration: BoxDecoration(
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.05),
//                     spreadRadius: 1,
//                     blurRadius: 8,
//                     offset: Offset(0, 8), // Changes position of shadow to bottom only
//                   ),
//                 ],
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(25),
//                 border: Border.all(color: color_.gray),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   IconButton(onPressed: (){}, icon:Icon(Icons.edit,color: color_.yellow,size:30,)),
//                 ],
//               ),
//             ),
//           ),
//           Positioned(
//               left: 12,
//               right: 19,
//               bottom: 10,
//               child: Row(
//                 mainAxisAlignment:MainAxisAlignment.start,
//                 children: [
//                   IconButton(onPressed: (){}, icon: Image.asset("assets/18.png",height: 60,)),
//                 ],
//               )
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sprint1/login/loginController.dart';
import '../../color_.dart';

class HomeParentScreen extends StatefulWidget {
  const HomeParentScreen({super.key});

  @override
  State<HomeParentScreen> createState() => _HomeParentScreenState();
}

class _HomeParentScreenState extends State<HomeParentScreen> {
  final LoginnnnnController _loginnnnnController= Get.put(LoginnnnnController());
  String _userName = 'Loading...';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userData = prefs.getString('user_data');

    if (userData != null) {
      Map<String, dynamic> userMap = jsonDecode(userData);
      setState(() {
        _userName = userMap['user']['student_name'];
      });
    } else {
      print("لم يتم العثور على بيانات المستخدم.");
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> gridItems = [
      {"image": "assets/1.png", "label": "دوام الطالب"},
      {"image": "assets/2.png", "label": "درجات الطالب"},
      {"image": "assets/3.png", "label": "المقررات الدراسية"},
      {"image": "assets/4.png", "label": "تقييم الطالب"},
      {"image": "assets/5.png", "label": "السلوك والملاحظات"},
      {"image": "assets/11.png", "label": "المواصلات"},
    ];

    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: 200,
            child: AppBar(
              title: Text(
                _userName,
                style: const TextStyle(color: color_.white),
              ),
              backgroundColor: color_.green,
              leading: IconButton(
                onPressed: () {
                  Get.toNamed('/profileStudent_Parent');
                },
                icon: const Icon(Icons.account_circle, size: 35, color: Colors.white),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications, color: Colors.white, size: 30),
                ),
                IconButton(
                  onPressed: () {
                    _loginnnnnController.logout().then((_){Get.offNamed('/login');});
                  },
                  icon: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(3.14159),
                    child: const Icon(Icons.logout, color: Colors.white, size: 30),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 90, bottom: 300, left: 10, right: 10),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    spreadRadius: 1,
                    blurRadius: 8,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Card(
                elevation: 0,
                margin: const EdgeInsets.fromLTRB(12, 0.1, 12, 0.1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                color: color_.white,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 0.001,
                    mainAxisExtent: 120,
                  ),
                  itemCount: gridItems.length,
                  itemBuilder: (context, index) {
                    String routeName;
                    switch (index) {
                      case 0:
                        routeName = '/Attend';
                        break;
                      case 1:
                        routeName = '/StudentDegreesScreen';
                        break;
                      case 2:
                        routeName = '/RequirementHomeworks';
                        break;
                      case 3:
                        routeName = '/StudentEvaluationScreen';
                        break;
                      case 4:
                        routeName = '/Behavior';
                        break;
                      case 5:
                        routeName = '/Bus';
                        break;
                      default:
                        routeName = '/';
                    }
                    return buildGridItem(gridItems[index]['image']!, gridItems[index]['label']!, routeName);
                  },
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 200,
            left: 100,
            right: 100,
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    spreadRadius: 1,
                    blurRadius: 8,
                    offset: const Offset(0, 8),
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: color_.gray),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(onPressed: () {Get.toNamed('/sendNote');}, icon: const Icon(Icons.edit, color: color_.yellow, size: 30)),
                ],
              ),
            ),
          ),
          Positioned(
            left: 12,
            right: 19,
            bottom: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(onPressed: () {Get.toNamed("/StudentWeektableScreen");}, icon: Image.asset("assets/18.png", height: 60)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildGridItem(String imagePath, String label, String routeName) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(routeName);
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 10.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: color_.green, width: 3.2),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(imagePath, height: 65),
              Text(label, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
