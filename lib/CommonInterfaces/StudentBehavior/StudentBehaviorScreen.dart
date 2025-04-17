// import 'package:flutter/material.dart';
//
// class Behavior extends StatelessWidget {
//   const Behavior({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     bool isGreen = true;
//     return Scaffold(
//         appBar:AppBar(
//         backgroundColor: const Color.fromRGBO(29, 122, 67, 1),
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             const Text(
//               'سلوك الطالب والملاحظات',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(width: 40),
//             Container(
//               margin: const EdgeInsets.symmetric(vertical: 10),
//               child: Image.asset(
//                 'assets/21861006-removebg-preview.png',
//                 height: 50,
//               ),
//             ),
//           ],
//         ),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             // يمكنك إضافة الوظيفة التي ترغب بها عند الضغط على السهم هنا
//           },
//         ),
//       ),
//
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             const SizedBox(height: 40,),
//             // Fixed containers for like and dislike
//             Container(
//               padding: const EdgeInsets.symmetric(vertical: 10),
//               color: Colors.white, // Adjust as needed
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.only(left: 20, right: 10, top: 15, bottom: 10),
//                     height: 150,
//                     color: const Color.fromRGBO(166, 233, 142, 1.0),
//                     child: Column(
//                       children: [
//                         Image.asset(
//                           'assets/like.png',
//                           height: 85,
//                         ),
//                         const SizedBox(height: 8),
//                         const Text("10", style: TextStyle(fontSize: 20)),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(width: 20),
//                   Container(
//                     padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 1),
//                     height: 150,
//                     color: const Color.fromRGBO(250, 143, 97, 1.0),
//                     child: Column(
//                       children: [
//                         Image.asset(
//                           'assets/dislike.png',
//                           height: 90,
//                         ),
//                         const SizedBox(height: 8),
//                         const Text("-10", style: TextStyle(fontSize: 20)),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 20),
//             // List of containers without ListView
//             SizedBox(
//               height: 550 , // Adjust height as needed
//
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: List.generate(
//                     5, // Number of containers
//                         (index) {
//                       return Container(
//                         color: isGreen ? const Color.fromRGBO(166, 233, 142, 1.0) : const Color.fromRGBO(249, 142, 97, 1.0),
//                         margin: const EdgeInsets.symmetric(vertical:20,horizontal: 30),
//                         child: Column(
//                           children: [
//                             Container(
//                               padding: const EdgeInsets.all(8),
//                               child: const Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text("12/4/2024"),
//                                   Text("الثلاثاء"),
//                                 ],
//                               ),
//                             ),
//                             const Divider(height: 1, color: Colors.black),
//                             const SizedBox(height: 4),
//                             const Text(
//                               ".... ....... ..... .....\n.... .. .....\n.... ....... ..... .....\n.... .. ..... .....\n.... ....... ..... .....\n",
//                               textAlign: TextAlign.center,
//                             )
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 1,),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sprint1/color_.dart';
import 'StudentBehaviorController.dart';

class Behavior extends StatelessWidget {
  const Behavior({super.key});

  @override
  Widget build(BuildContext context) {
    final StudentBehaviorController controller = Get.put(StudentBehaviorController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: color_.green,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
             Text(
              'سلوك الطالب والملاحظات',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
                         ),
            const SizedBox(width: 40),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Image.asset(
                'assets/21861006-removebg-preview.png',
                height: 50,
              ),
            ),
          ],
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: () {
            Get.back();
            // يمكنك إضافة الوظيفة التي ترغب بها عند الضغط على السهم هنا
          },
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        int positiveCount = controller.studentBehaviors.where((b) => b.type == 'positive').length;
        int negativeCount = controller.studentBehaviors.where((b) => b.type == 'negative').length;

        return SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40),
              // Fixed containers for like and dislike
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 20, right: 10, top: 15, bottom: 10),
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color.fromRGBO(166, 233, 142, 1.0),
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/like.png',
                            height: 85,
                          ),
                          const SizedBox(height: 8),
                          Text("$positiveCount", style: const TextStyle(fontSize: 20)),
                        ],
                      ),
                    ),
                    const SizedBox(width: 30),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 1),
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color.fromRGBO(250, 143, 97, 1.0),
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/dislike.png',
                            height: 90,
                          ),
                          const SizedBox(height: 8),
                          Text("$negativeCount", style: const TextStyle(fontSize: 20)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // List of containers without ListView
              if (controller.studentBehaviors.isEmpty)
                const Center(child: Text('No behavior notes available')),
              if (controller.studentBehaviors.isNotEmpty)
                SizedBox(
                  height: 550,
                  child: SingleChildScrollView(
                    child: Column(
                      children: controller.studentBehaviors.map((behavior) {
                        bool isGreen = behavior.type == 'positive';
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                  color: isGreen
                                      ? const Color.fromRGBO(166, 233, 142, 1.0)
                                      : const Color.fromRGBO(249, 142, 97, 1.0),
                                ),
                                padding: const EdgeInsets.all(11),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(behavior.sentAt),
                                    const Text("الثلاثاء"), // يمكن أن يتم حساب اليوم حسب التاريخ إذا كان ذلك مطلوبًا
                                  ],
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  color: Color.fromRGBO(230, 230, 230, 1.0),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                ),
                                padding: const EdgeInsets.all(11),
                                child: Text(
                                  behavior.note,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              // const SizedBox(height: 1),
            ],
          ),
        );
      }),
    );
  }
}
