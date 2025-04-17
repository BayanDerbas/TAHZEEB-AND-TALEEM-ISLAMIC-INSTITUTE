import 'package:flutter/material.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(29, 122, 67, 1),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text(
              'الإشعارات',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 110),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Image.asset(
                'assets/notification.png',
                height: 40,
              ),
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // يمكنك إضافة الوظيفة التي ترغب بها عند الضغط على السهم هنا
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: List.generate(
            10, // Number of containers
                (index) {
              return Container(
                color: const Color.fromRGBO(227, 227, 227, 1.0),
                margin: const EdgeInsets.symmetric(vertical:7,horizontal: 10),
                child:  Container(
                  margin: const EdgeInsets.symmetric(vertical:10,horizontal: 10),

                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green,width: 1.5),
                  ),
               //   color: Colors.grey[300],
                  padding: const EdgeInsets.all(10),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                ' الثلاثاء'' 2/4/2023 ',
                                style: TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                '... ........ ...... ........ ....... ....... ........\n...... ........ ....... ....... ........',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Icon(
                              Icons.check_box,
                              size: 30,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),      ),
    );
  }
}
