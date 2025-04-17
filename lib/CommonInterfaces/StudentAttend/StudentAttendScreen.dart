
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sprint1/color_.dart';

import 'StudentAttendController.dart';
import 'StudentAttendModel.dart';

class Attend extends StatelessWidget {
  const Attend({super.key});

  @override
  Widget build(BuildContext context) {
    final StudentAttendanceController controller = Get.put(StudentAttendanceController());

    return DefaultTabController(
      length: 3,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor:  color_.green,
          title: Text(
             'دوام الطالب',
             style: TextStyle(
               color: Colors.white,
               fontSize: 20,
               fontWeight: FontWeight.bold,
             ),
           ),
        centerTitle: true,
        //   actions: [
        //      Padding(
        //        padding: EdgeInsets.all(3),
        //        child: Image.asset(
        //   'assets/attend.png',
        //   height: 50,
        // ),
        //      ),

         // ],
          leading: IconButton(
            icon: const Icon(Icons.arrow_back,color: Colors.white,),
            onPressed: () {
              Get.back();
              // Add your navigation logic here
            },
         ),
          bottom: const TabBar(
            labelColor: Colors.white,
            indicatorColor: Colors.amber,
            tabs: [
              Tab(text: 'تأخر'),
              Tab(text: 'غياب'),
              Tab(text: 'حضور'),
            ],
          ),
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          int totalLate = controller.summary.value.late;
          int totalAbsent = controller.summary.value.absent.unjustified + controller.summary.value.absent.justified;
          int totalPresent = controller.summary.value.present;

          return Column(
            children: [
              SizedBox(
                height: 200,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    double width = constraints.maxWidth;
                    double height = constraints.maxHeight;
                    double containerHeight = height * 0.8;
                    double boxSize = width * 0.2;
                    double boxTopPosition = containerHeight - boxSize / 1.5;

                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 30),
                              height: 150,
                              decoration: BoxDecoration(
                                color: color_.whitegray,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    blurRadius: 2,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text('التأخر \nالكلي', textAlign: TextAlign.center, style: TextStyle(fontSize: 20)),
                                    ],
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text('الغياب \nالكلي', textAlign: TextAlign.center, style: TextStyle(fontSize: 20)),
                                    ],
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text('الحضور \nالكلي', textAlign: TextAlign.center, style: TextStyle(fontSize: 20)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: boxTopPosition,
                              left: width * 0.17 - boxSize / 2,
                              child: Container(
                                width: boxSize,
                                height: boxSize,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: color_.yellow,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  '$totalPresent',
                                  style: const TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: boxTopPosition,
                              left: width * 0.46 - boxSize / 2,
                              child: Container(
                                width: boxSize,
                                height: boxSize,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: color_.yellow,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  '$totalAbsent',
                                  style: const TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: boxTopPosition,
                              right: width * 0.16 - boxSize / 2,
                              child: Container(
                                width: boxSize,
                                height: boxSize,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: color_.yellow,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  '$totalLate',
                                  style: const TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 80),
              Expanded(
                child: TabBarView(
                  children: [
                    _buildAttendanceList(controller.attendance, 'تأخر'),
                    _buildAttendanceList(controller.attendance, 'غياب'),
                    _buildAttendanceList(controller.attendance, 'حاضر'),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildAttendanceList(RxList<Attendance> attendance, String type) {
    var filteredAttendance = attendance.where((a) => a.attendanceStatus == type).toList();

    return SingleChildScrollView(
      child:  type != 'غياب' ?
        Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            color: const Color.fromRGBO(166, 233, 142, 1.0),
            child: ExpansionTile(
              backgroundColor:  const Color.fromRGBO(166, 233, 142, 1.0),
              title: Text(
                type == 'تأخر'
                    ? 'التأخر'
                    : 'الحضور',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              children: [
                const Divider(color: Colors.black),
              SizedBox(
                  height: 200,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: filteredAttendance.length,
                    itemBuilder: (context, index) {
                      var attendance = filteredAttendance[index];
                      return ListTile(
                        title: Text("يوم ${attendance.getDayNameInArabic()} بتاريخ ${attendance.attendanceDate}"),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ):Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            color: const  Color.fromRGBO(250, 143, 97, 1.0),
            child: ExpansionTile(
              backgroundColor: const Color.fromRGBO(250, 143, 97, 1.0),
              title: const Text(
                'غياب غير مبرر',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              children: [
                const Divider(color: Colors.black),
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: filteredAttendance.length,
                    itemBuilder: (context, index) {
                      var attendance = filteredAttendance[index];
                      if (attendance.isJustified) {
                        return const SizedBox.shrink(); // لا تقم بعرض الغياب المبرر هنا
                      } else {
                        return ListTile(
                          title: Text("يوم ${attendance.getDayNameInArabic()} بتاريخ ${attendance.attendanceDate}"),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            color: const Color.fromRGBO(166, 233, 142, 1.0),
            child: ExpansionTile(
              backgroundColor: const Color.fromRGBO(166, 233, 142, 1.0),
              title: const Text(
                'غياب مبرر',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              children: [
                const Divider(color: Colors.black),
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: filteredAttendance.length,
                    itemBuilder: (context, index) {
                      var attendance = filteredAttendance[index];
                      if (attendance.isJustified) {
                        return ListTile(
                          title: Text("يوم ${attendance.getDayNameInArabic()} بتاريخ ${attendance.attendanceDate}"),
                        );
                      } else {
                        return const SizedBox.shrink(); // لا تقم بعرض الغياب غير المبرر هنا
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
// غياب حاضر تأخر
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'StudentAttendController.dart';
// import 'StudentAttendModel.dart';
// import 'package:sprint1/color_.dart';
//
// class Attend extends StatelessWidget {
//   const Attend({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final StudentAttendanceController controller = Get.put(StudentAttendanceController());
//
//     return DefaultTabController(
//       length: 3,
//       initialIndex: 1,
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: color_.green,
//           title: Text(
//             'دوام الطالب',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           centerTitle: true,
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back, color: Colors.white),
//             onPressed: () {
//               Get.back();
//             },
//           ),
//           bottom: const TabBar(
//             labelColor: Colors.white,
//             indicatorColor: Colors.amber,
//             tabs: [
//               Tab(text: 'تأخر'),
//               Tab(text: 'غياب'),
//               Tab(text: 'حاضر'),
//             ],
//           ),
//         ),
//         body: Obx(() {
//           if (controller.isLoading.value) {
//             return const Center(child: CircularProgressIndicator());
//           }
//
//           int totalLate = controller.summary.value.late;
//           int totalAbsent = controller.summary.value.absent.unjustified + controller.summary.value.absent.justified;
//           int totalPresent = controller.summary.value.present;
//
//           return Column(
//             children: [
//               SizedBox(
//                 height: 200,
//                 child: LayoutBuilder(
//                   builder: (context, constraints) {
//                     double width = constraints.maxWidth;
//                     double height = constraints.maxHeight;
//                     double containerHeight = height * 0.8;
//                     double boxSize = width * 0.2;
//                     double boxTopPosition = containerHeight - boxSize / 1.5;
//
//                     return Center(
//                       child: Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Stack(
//                           clipBehavior: Clip.none,
//                           children: [
//                             Container(
//                               padding: const EdgeInsets.only(left: 16, right: 16, bottom: 30),
//                               height: 150,
//                               decoration: BoxDecoration(
//                                 color: color_.whitegray,
//                                 borderRadius: BorderRadius.circular(10),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.grey.withOpacity(0.5),
//                                     blurRadius: 2,
//                                     offset: const Offset(0, 3),
//                                   ),
//                                 ],
//                               ),
//                               child: const Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                 children: [
//                                   Column(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       Text('التأخر \nالكلي', textAlign: TextAlign.center, style: TextStyle(fontSize: 20)),
//                                     ],
//                                   ),
//                                   Column(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       Text('الغياب \nالكلي', textAlign: TextAlign.center, style: TextStyle(fontSize: 20)),
//                                     ],
//                                   ),
//                                   Column(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       Text('الحضور \nالكلي', textAlign: TextAlign.center, style: TextStyle(fontSize: 20)),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Positioned(
//                               top: boxTopPosition,
//                               left: width * 0.17 - boxSize / 2,
//                               child: Container(
//                                 width: boxSize,
//                                 height: boxSize,
//                                 alignment: Alignment.center,
//                                 decoration: BoxDecoration(
//                                   color: color_.yellow,
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 child: Text(
//                                   '$totalPresent',
//                                   style: const TextStyle(
//                                     fontSize: 24,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Positioned(
//                               top: boxTopPosition,
//                               left: width * 0.46 - boxSize / 2,
//                               child: Container(
//                                 width: boxSize,
//                                 height: boxSize,
//                                 alignment: Alignment.center,
//                                 decoration: BoxDecoration(
//                                   color: color_.yellow,
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 child: Text(
//                                   '$totalAbsent',
//                                   style: const TextStyle(
//                                     fontSize: 24,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Positioned(
//                               top: boxTopPosition,
//                               right: width * 0.16 - boxSize / 2,
//                               child: Container(
//                                 width: boxSize,
//                                 height: boxSize,
//                                 alignment: Alignment.center,
//                                 decoration: BoxDecoration(
//                                   color: color_.yellow,
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 child: Text(
//                                   '$totalLate',
//                                   style: const TextStyle(
//                                     fontSize: 24,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Expanded(
//                 child: TabBarView(
//                   children: [
//                     _buildAttendanceList(controller.attendance, 'تأخر'),
//                     _buildAttendanceList(controller.attendance, 'غياب'),
//                     _buildAttendanceList(controller.attendance, 'حاضر'),
//                   ],
//                 ),
//               ),
//             ],
//           );
//         }),
//       ),
//     );
//   }
//
//   Widget _buildAttendanceList(RxList<Attendance> attendance, String type) {
//     var filteredAttendance;
//
//     if (type == 'تأخر') {
//       filteredAttendance = attendance.where((a) => a.attendanceStatus == 'تأخر').toList();
//     } else if (type == 'غياب') {
//       filteredAttendance = attendance.where((a) => a.attendanceStatus == 'غياب').toList();
//     } else if (type == 'حاضر') {
//       filteredAttendance = attendance.where((a) => a.attendanceStatus == 'حاضر').toList();
//     }
//
//     return SingleChildScrollView(
//       child: type != 'absent'
//           ? Column(
//         children: [
//           Container(
//             margin: const EdgeInsets.symmetric(horizontal: 20),
//             color: const Color.fromRGBO(166, 233, 142, 1.0),
//             child: ExpansionTile(
//               backgroundColor: const Color.fromRGBO(166, 233, 142, 1.0),
//               title: Text(
//                 type == 'التأخر' ? 'التأخر' : 'الإذن',
//                 style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               children: [
//                 const Divider(color: Colors.black),
//                 SizedBox(
//                   height: 200,
//                   child: ListView.builder(
//                     shrinkWrap: true,
//                     itemCount: filteredAttendance.length,
//                     itemBuilder: (context, index) {
//                       var attendance = filteredAttendance[index];
//                       return ListTile(
//                         title: Text("يوم ${attendance.getDayNameInArabic()} بتاريخ ${attendance.attendanceDate}"),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       )
//           : Column(
//         children: [
//           Container(
//             margin: const EdgeInsets.symmetric(horizontal: 10),
//             color: const Color.fromRGBO(250, 143, 97, 1.0),
//             child: ExpansionTile(
//               backgroundColor: const Color.fromRGBO(250, 143, 97, 1.0),
//               title: const Text(
//                 'غياب غير مبرر',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               children: [
//                 const Divider(color: Colors.black),
//                 SizedBox(
//                   height: 200,
//                   child: ListView.builder(
//                     shrinkWrap: true,
//                     itemCount: filteredAttendance.length,
//                     itemBuilder: (context, index) {
//                       var attendance = filteredAttendance[index];
//                       if (attendance.isJustified == false) {
//                         return ListTile(
//                           title: Text("يوم ${attendance.getDayNameInArabic()} بتاريخ ${attendance.attendanceDate}"),
//                         );
//                       }
//                       return const SizedBox.shrink();
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 20),
//           Container(
//             margin: const EdgeInsets.symmetric(horizontal: 10),
//             color: const Color.fromRGBO(166, 233, 142, 1.0),
//             child: ExpansionTile(
//               backgroundColor: const Color.fromRGBO(166, 233, 142, 1.0),
//               title: const Text(
//                 'غياب مبرر',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               children: [
//                 const Divider(color: Colors.black),
//                 SizedBox(
//                   height: 200,
//                   child: ListView.builder(
//                     shrinkWrap: true,
//                     itemCount: filteredAttendance.length,
//                     itemBuilder: (context, index) {
//                       var attendance = filteredAttendance[index];
//                       if (attendance.isJustified == true) {
//                         return ListTile(
//                           title: Text("يوم ${attendance.getDayNameInArabic()} بتاريخ ${attendance.attendanceDate}"),
//                         );
//                       }
//                       return const SizedBox.shrink();
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
