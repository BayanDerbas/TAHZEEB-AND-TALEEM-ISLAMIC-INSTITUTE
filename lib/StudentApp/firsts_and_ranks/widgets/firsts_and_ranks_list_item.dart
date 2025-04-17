import 'package:flutter/material.dart';

class FirstsAndRanksListItem extends StatelessWidget {
  final String leadingText, title, trailingText;
  final int index;

  const FirstsAndRanksListItem(
      {super.key,
      this.leadingText = "سارة",
      this.title = "حادي عشر ش2",
      this.trailingText = "97.80%",
      this.index = 1});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
      leading: index > 3
          ? Text(
              leadingText,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            )
          : Image.asset(
              "assets/${index}_medal.png",
              width: 30,
            ),
      title: Text(title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      trailing: Text(trailingText,
          style: TextStyle(
              color: Colors.yellow.shade600,
              fontSize: 17,
              fontWeight: FontWeight.bold)),
    );
  }
}
