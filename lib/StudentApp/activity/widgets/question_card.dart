import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../activity_controller.dart';

class QuestionCard extends StatefulWidget {
  final String question;
  final List<String> options;
  final bool show;

  const QuestionCard(
      {super.key, required this.question, required this.options, required this.show});

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  final ActivityController activityController = Get.put(ActivityController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double blur = widget.show ? 0 : 5;
    return Obx(
      () {
        return SingleChildScrollView(
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Transform(
                  transform: Matrix4.skewX(-0.2),
                  child: CustomPaint(
                    foregroundPainter: BorderPainter(),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        widget.question,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                const Divider(),
                const SizedBox(height: 10),
                ...widget.options
                    .asMap()
                    .map((i, option) {
                      return MapEntry(
                          i,
                          InkWell(
                            onTap: () {
                              activityController.answer(i + 1);
                              print(activityController.answer.value);
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              child: Transform(
                                transform: Matrix4.skewX(-0.2),
                                child: CustomPaint(
                                  foregroundPainter: BorderPainter(),
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: activityController.answer.value ==
                                              i + 1
                                          ? Colors.grey.shade400
                                          : Colors.grey.shade200,
                                    ),
                                    padding: const EdgeInsets.all(16),
                                    child: Text(
                                      option,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ));
                    })
                    .values
                    ,
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }
}

class BorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double sh = size.height; // for convenient shortage
    double sw = size.width; // for convenient shortage
    double cornerSide = sh * 0.3; // desirable value for corners side

    Paint paint = Paint()
      ..color = Colors.green.shade900
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square;

    Path path = Path()
      ..moveTo(0, sh - cornerSide)
      ..conicTo(0, sh, cornerSide, sh, 50)
      ..moveTo(sw, cornerSide)
      ..conicTo(sw, 0, sw - cornerSide, 0, 50);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(BorderPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(BorderPainter oldDelegate) => false;
}
