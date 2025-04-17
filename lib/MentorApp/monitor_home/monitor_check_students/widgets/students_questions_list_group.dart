import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sprint1/color_.dart';

import '../monitor_check_students_controller.dart';
import 'students_questions_list_item.dart';

class StudentsQuestionsListGroup extends StatelessWidget {
  StudentsQuestionsListGroup({super.key});

  final MonitorCheckStudentsController monitorCheckStudentsController =
      Get.put(MonitorCheckStudentsController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              right: BorderSide(width: 18, color: color_.yellow)),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // color of the shadow
              spreadRadius: 5, // spread radius
              blurRadius: 7, // blur radius
              offset: const Offset(1, 4), // changes position of shadow
            ),
          ],
        ),
        child: ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: monitorCheckStudentsController
              .students.value.checkListAttendance!.length,
          itemBuilder: (BuildContext context, int index) {
            var title = monitorCheckStudentsController
                    .students.value.checkListAttendance![index].firstName! +
                " " +
                monitorCheckStudentsController
                    .students.value.checkListAttendance![index].lastName!;
            return StudentsQuestionsListItem(title: title, index: index);
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(
              color: Colors.black45,
            );
          },
        ),
      );
    });
  }
}
