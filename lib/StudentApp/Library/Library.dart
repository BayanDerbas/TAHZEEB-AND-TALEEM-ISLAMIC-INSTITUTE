// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'LibrayTeacherController.dart';
//
// class Library extends StatelessWidget {
//   const Library({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final LibraryController controller = Get.put(LibraryController());
//
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: const Color.fromRGBO(29, 122, 67, 1),
//           title: Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               const Text(
//                 'المكتبة',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(width: 90),
//               Container(
//                 margin: const EdgeInsets.symmetric(vertical: 10),
//                 child: Image.asset(
//                   'assets/lib.png',
//                   height: 50,
//                 ),
//               ),
//             ],
//           ),
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back),
//             onPressed: () {
//               // يمكنك إضافة الوظيفة التي ترغب بها عند الضغط على السهم هنا
//             },
//           ),
//           bottom: const TabBar(
//             labelColor: Colors.white,
//             indicatorColor: Colors.amber,
//             tabs: [
//               Tab(
//                 text: 'الكتب',
//               ),
//               Tab(
//                 text: 'الملفات',
//               ),
//             ],
//           ),
//         ),
//         body: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: TextField(
//                 onChanged: controller.searchLibraryItems,
//                 decoration: const InputDecoration(
//                   hintText: 'tap here to search ..',
//                   border: OutlineInputBorder(),
//                   prefixIcon: Icon(Icons.search),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: TabBarView(
//                 children: [
//                   Obx(() => ListView.builder(
//                     itemCount: controller.searchBooks.length,
//                     itemBuilder: (context, index) {
//                       final item = controller.searchBooks[index];
//                       return ListTile(
//                         leading: Image.asset('assets/lib.png', height: 100, width: 100),
//                         title: Text(item.title),
//                         subtitle: const Text("... ... ..."),
//                         onTap: () {
//                           controller.downloadFile(item.downloadUrl, '${item.title}.pdf');
//                         },
//                       );
//                     },
//                   )),
//                   Obx(() => ListView.builder(
//                     itemCount: controller.searchDocuments.length,
//                     itemBuilder: (context, index) {
//                       final item = controller.searchDocuments[index];
//                       return ListTile(
//                         leading: Image.asset('assets/lib.png', height: 100, width: 100),
//                         title: Text(item.title),
//                         subtitle: const Text("... ... ..."),
//                         onTap: () {
//                           controller.downloadFile(item.downloadUrl, '${item.title}.pdf');
//                         },
//                       );
//                     },
//                   )),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }





import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sprint1/color_.dart';
import 'LibrayController.dart';

class Library extends StatelessWidget {
  const Library({super.key});
  @override
  Widget build(BuildContext context) {
    final LibraryController controller = Get.put(LibraryController());

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: color_.green,
          title: const Text(
            'المكتبة',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          actions: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Image.asset(
                'assets/lib.png',
                height: 50,
              ),
            ),
          ],
          leading: IconButton(
            icon: const Icon(Icons.arrow_back,color: Colors.white,),
            onPressed: () {
              Get.back();
              // يمكنك إضافة الوظيفة التي ترغب بها عند الضغط على السهم هنا
            },
          ),
          bottom: const TabBar(
            labelColor: Colors.white,
            indicatorColor: Colors.amber,
            tabs: [
              Tab(
                text: 'الكتب',
              ),
              Tab(
                text: 'الملفات',
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: controller.searchLibraryItems,
                decoration: const InputDecoration(
                  hintText: 'tap here to search ..',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Obx(() => ListView.builder(
                    itemCount: controller.searchBooks.length,
                    itemBuilder: (context, index) {
                      final item = controller.searchBooks[index];
                      return ListTile(
                        leading: Image.asset('assets/lib.png', height: 100, width: 100),
                        title: Text(item.title),
                        subtitle: const Text("... ... ..."),
                        onTap: () {
                          controller.downloadFile(item.id, '${item.title}.pdf'); // تمرير id هنا
                        },
                      );
                    },
                  )),
                  Obx(() => ListView.builder(
                    itemCount: controller.searchDocuments.length,
                    itemBuilder: (context, index) {
                      final item = controller.searchDocuments[index];
                      return ListTile(
                        leading: Image.asset('assets/lib.png', height: 100, width: 100),
                        title: Text(item.title),
                        subtitle: const Text("... ... ..."),
                        onTap: () {
                          controller.downloadFile(item.id, '${item.title}.pdf'); // تمرير id هنا
                        },
                      );
                    },
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}