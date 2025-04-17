import 'package:flutter/material.dart';

import '../first_and_ranks_model.dart';
import 'firsts_and_ranks_list_group.dart';

class FirstsAndRanksGrayBoxGroup extends StatelessWidget {
  final String title;

  final List<FirstsAndRanksModel> list;
  const FirstsAndRanksGrayBoxGroup(
      {super.key, required this.title, required this.list});

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
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          FirstsAndRanksListGroup(list: list)
        ],
      ),
    );
  }
}
