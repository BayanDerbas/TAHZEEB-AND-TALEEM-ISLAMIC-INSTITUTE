import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sprint1/color_.dart';

import '../monitor_check_students_controller.dart';

class StudentsQuestionsListItem extends StatefulWidget {
  final String leadingText, title, trailingText;
  final int index;
  bool isChecked;

  StudentsQuestionsListItem(
      {super.key,
      this.isChecked = false,
      this.leadingText = "",
      this.title = "سارة",
      this.trailingText = "97.80%",
      this.index = 1});

  @override
  State<StudentsQuestionsListItem> createState() =>
      _StudentsQuestionsListItemState();
}

class _StudentsQuestionsListItemState extends State<StudentsQuestionsListItem> {
  final MonitorCheckStudentsController monitorCheckStudentsController =
      Get.put(MonitorCheckStudentsController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
        leading: SizedBox(
          width: 30,
          child: Row(
            children: [
              Icon(
                Icons.person_2_rounded,
                color:color_.yellow,
              ),
            ],
          ),
        ),
        trailing: Theme(
          data: ThemeData(
            checkboxTheme: CheckboxThemeData(
              fillColor: MaterialStateProperty.all(Color(0Xfffcd511)),
              checkColor: MaterialStateProperty.all(Colors.white),
              side: BorderSide(color: Color(0Xfffcd511)),
            ),
          ),
          child: Checkbox(
            value: monitorCheckStudentsController.studentsCheck[widget.index],
            onChanged: (bool? value) {
              setState(() {
                monitorCheckStudentsController.studentsCheck[widget.index] =
                    value!;
              });
            },
          ),
        ),
        title: Text(widget.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      );
    });
  }
}
