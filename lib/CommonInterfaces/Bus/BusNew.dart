// import 'package:flutter/material.dart';
// class Bus extends StatelessWidget {
//   const Bus({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return  DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Color.fromRGBO(29, 122, 67, 1),
//           title: Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               Text(
//                 'المواصلات',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(width: 90),
//               Container(
//                 margin: EdgeInsets.symmetric(vertical: 10),
//                 child: Image.asset(
//                   'assets/bus.png',
//                   height: 50,
//                 ),
//               ),
//             ],
//           ),
//           leading: IconButton(
//             icon: Icon(Icons.arrow_back),
//             onPressed: () {
//               // يمكنك إضافة الوظيفة التي ترغب بها عند الضغط على السهم هنا
//             },
//           ),
//           bottom: TabBar(
//             labelColor: Colors.white,
//             indicatorColor: Colors.amber,
//             tabs: [
//               Tab(
//                 text: 'دليل النقل',
//               ),
//               Tab(
//                 text: 'ملاحظات النقل',
//               ),
//             ],
//           ),
//         ),
//         body: TabBarView(
//           children: [
//             Center(
//               child: Container(
//                 margin: EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color: Colors.grey[300]
//                 ),
//                 child: Center(
//                   child: Text("... ........ .... ........ .... ..... ........ ....... .......\n"
//                       " ........ ........ ........ ........  ...... ......... .......... .......\n"
//                       " ..... ....... ..... .... ... ... ..... ... .... ...... "),
//                 ),
//               ),
//             ),
//             ListView.builder(
//               shrinkWrap: true,
//               // Add this line
//               itemCount: 10,
//               // Change the itemCount to the number of items you want in the list
//               itemBuilder: (context, index) {
//                 // Replace the CheckboxListTile with your custom logic
//                 return Container(
//                   margin: EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     //borderRadius: BorderRadius.circular(8),
//                     color: Colors.grey[300],
//                     boxShadow: [
//                       BoxShadow(),
//                     ]
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Text("غياب / تأخر /قسط"),
//                       ),
//                       Divider(),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Text("... ........ .... ........ .... ..... ........ ....... ....... ........\n"
//                             " ........ ........ ........  ...... ......... .......... ....... .....\n"
//                             " ....... ..... .... ... ... ..... ... .... ...... "),
//                       ),
//                       Divider(),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text("2/4/2023"),
//                             Checkbox(value: true, onChanged: (value) {
//
//                             },)
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sprint1/color_.dart';
import 'bus_notes_controller.dart';



class Bus extends StatelessWidget {
  final BusController controller = Get.put(BusController());

   Bus({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: color_.green,
          title: const Text(
            'المواصلات',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 10),
              child: Image.asset(
                'assets/bus.png',
                height: 50,
              ),
            ),
          ],
          centerTitle: true,
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
                text: 'دليل النقل',
              ),
              Tab(
                text: 'ملاحظات النقل',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[300],
                ),
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (controller.transport.isEmpty) {
                    return const Center(child: Text("لا توجد بيانات عن النقل"));
                  } else {
                    return ListView.builder(
                      itemCount: controller.transport.length,
                      itemBuilder: (context, index) {
                        var transport = controller.transport[index];
                        return ListTile(
                          title: Text(transport.routeName),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('الوجهة: من ${transport.startLocation} إلى ${transport.endLocation}'),
                              Text('ينطلق الساعة: ${transport.arrivalTime}'),
                              Text('نوع المركبة: ${transport.vehicleType} '),
                              // Text('الشوفير: ${transport.driverName}'),
                              // Text('رقم الاتصال: ${transport.driverNumber}'),
                              const Text('__________________________________________________')
                            ],
                          ),

                        );
                      },
                    );
                  }
                }),
              ),
            ),
            Obx(() {
              if (controller.isLoading.value) {
                print("adfd");
              return const Center(child: CircularProgressIndicator());
              } else if (controller.busNotes.isEmpty) {
                print("No bus notes available");
                return const Center(child: Text("No bus notes available"));
              } else {
                print("Displaying bus notes");
                return ListView.builder(
                  itemCount: controller.busNotes.length,
                  itemBuilder: (context, index) {
                    var note = controller.busNotes[index];
                    return Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                         borderRadius: BorderRadius.circular(8),
                        boxShadow: const [
                          BoxShadow(),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(note.status),
                                Text(note.date),

                              ],
                            ),
                          ),
                          const Divider(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(note.note),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
