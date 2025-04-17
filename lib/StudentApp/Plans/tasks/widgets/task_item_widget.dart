import 'package:flutter/material.dart';

class TaskItemWidget extends StatefulWidget {
  final String taskName;
  bool isChecked;
  TaskItemWidget({super.key, required this.taskName, required this.isChecked});

  @override
  State<TaskItemWidget> createState() => _TaskItemWidgetState();
}

class _TaskItemWidgetState extends State<TaskItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Theme(
          data: ThemeData(
            checkboxTheme: CheckboxThemeData(
              fillColor: WidgetStateProperty.all(const Color(0Xfffcd511)),
              checkColor: WidgetStateProperty.all(Colors.white),
              side: const BorderSide(color: Color(0Xfffcd511)),
            ),
          ),
          child: Checkbox(
            value: widget.isChecked,
            onChanged: (bool? value) {
              setState(() {
                widget.isChecked = value!;
              });
            },
          ),
        ),
        Text(widget.taskName),
      ],
    );
  }
}
