import 'package:flutter/material.dart';

import '../first_and_ranks_model.dart';
import 'firsts_and_ranks_list_item.dart';

class FirstsAndRanksListGroup extends StatelessWidget {
  const FirstsAndRanksListGroup({super.key, required this.list});
  final List<FirstsAndRanksModel> list;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border:
            Border(right: BorderSide(width: 18, color: Colors.yellow.shade600)),
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
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return FirstsAndRanksListItem(
            title: "${list[index].firstName!} ${list[index].lastName!}",
            trailingText: "${list[index].totalMarks}%",
            leadingText: (index + 1).toString(),
            index: index + 1,
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            color: Colors.black45,
          );
        },
      ),
    );
  }
}
