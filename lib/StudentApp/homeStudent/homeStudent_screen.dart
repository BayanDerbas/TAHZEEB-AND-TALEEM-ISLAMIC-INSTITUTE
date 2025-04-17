import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sprint1/color_.dart';
import 'package:sprint1/login/loginController.dart';

class homestudent_screen extends StatefulWidget {

   const homestudent_screen({super.key});

  @override
  State<homestudent_screen> createState() => _homestudent_screenState();
}

class _homestudent_screenState extends State<homestudent_screen> {
  final LoginnnnnController loginController = Get.put(LoginnnnnController());

  String _userName = 'Loading...';

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userData = prefs.getString('user_data');

    if (userData != null) {
      // تحويل سلسلة JSON إلى خريطة
      Map<String, dynamic> userMap = jsonDecode(userData);

      // استخراج اسم المستخدم من الخريطة
      setState(() {
        _userName = userMap['user']['full_name'];
        print("..........................................................$_userName");
      });

      print("اسم المستخدم: $_userName");
    } else {
      print("لم يتم العثور على بيانات المستخدم.");
    }
  }
@override
  void initState() {
    super.initState();
    _loadUserData();

}

  @override
  Widget build(BuildContext context) {

    final List<Map<String, String>> gridItems = [
      {"image": "assets/1.png", "label": "دوام الطالب"},
      {"image": "assets/2.png", "label": "درجات الطالب"},
      {"image": "assets/3.png", "label": "المقررات الدراسية"},
      {"image": "assets/4.png", "label": "تقييم الطالب"},
      {"image": "assets/5.png", "label": "السلوك والملاحظات"},
      {"image": "assets/10.png", "label": "التسلية و النشاطات"},
      {"image": "assets/11.png", "label": "المواصلات"},
      {"image": "assets/8.png", "label": "المكتبة"},
    ];

    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: 200,
            child: AppBar(
              title: Text(
             _userName,
                style: const TextStyle(color: color_.white, fontSize: 20),
              ),
              backgroundColor: color_.green,
              leading: IconButton(
                onPressed: () {
                  Get.toNamed('/profile');
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
                    loginController.logout().then((_) {
                      Get.offNamed('/login');
                    });
                  },
                  icon: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(3.14),
                    child: const Icon(Icons.logout, color: Colors.white, size: 30),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 90, bottom: 175, left: 10, right: 10),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    spreadRadius: 1,
                    blurRadius: 8,
                    offset: const Offset(0, 8), // Changes position of shadow to bottom only
                  ),
                ],
              ),
              child: Card(
                elevation: 0, // Set card elevation to 0 to use custom shadow
                margin: const EdgeInsets.fromLTRB(12, 0.1, 12, 0.1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                color: color_.white,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 0.001, // Very small spacing
                    mainAxisExtent: 125,
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
                      routeName = '/ActivityScreen';
                      break;
                      case 6:
                        routeName = '/Bus'; // Navigate to the bus page
                        break;
                      case 7:
                        routeName = '/Library'; // Navigate to the library page
                        break;
                    // Add more cases for additional pages
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
            bottom: 100,
            left: 25,
            right: 25,
            child: Container(
              height: 50, // Adjust the height as needed
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    spreadRadius: 1,
                    blurRadius: 8,
                    offset: const Offset(0, 8), // Changes position of shadow to bottom only
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: color_.gray),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 30,),
                 IconButton(onPressed: (){Get.toNamed("/FirstsAndRanksScreen");}, icon:Image.asset("assets/15.png",height: 60,),),
                  const SizedBox(width: 20,),
                  const VerticalDivider(
                    color: color_.gray,
                    thickness: 2,
                    width: 20,
                    indent: 5,
                    endIndent: 5,
                  ),
                  const SizedBox(width: 40,),
                  IconButton(onPressed: (){Get.toNamed("/StudentQuestionScreen");}, icon:const Icon(Icons.contact_support_outlined,color: color_.yellow,size: 30,)),
                  const SizedBox(width: 40,),
                  const VerticalDivider(
                    color: color_.gray,
                    thickness: 2,
                    width: 20,
                    indent: 5,
                    endIndent: 5,
                  ),
                  const SizedBox(width: 17,),
                  IconButton(onPressed: (){Get.toNamed("/StudentConsultScreen");}, icon:const Icon(Icons.edit,color: color_.yellow,size:30,)),
                ],
              ),
            ),
          ),
          Positioned(
              bottom: 10,
              child: Row(
                mainAxisAlignment:MainAxisAlignment.spaceAround,
                children: [
                  IconButton(onPressed: (){ Get.toNamed('/DrawingApp');}, icon: Image.asset("assets/17.png",height: 60,)),
                  const SizedBox(width: 230,),
                 IconButton(onPressed: (){ Get.toNamed('/StudentWeektableScreen');}, icon: Image.asset("assets/18.png",height: 57,)),
                ],
              )
          )
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
            color: Colors.grey.shade100,
            border: Border.all(color: color_.ggreen, width: 2.5),
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
