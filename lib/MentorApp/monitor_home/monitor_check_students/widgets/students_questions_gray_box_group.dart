import 'package:flutter/material.dart';

import 'students_questions_list_group.dart';

class StudentsQuestionsGrayBoxGroup extends StatelessWidget {
  final String title;

  const StudentsQuestionsGrayBoxGroup({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // color of the shadow
            spreadRadius: 2, // spread radius
            blurRadius: 2, // blur radius
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [StudentsQuestionsListGroup()],
      ),
    );
  }
}
