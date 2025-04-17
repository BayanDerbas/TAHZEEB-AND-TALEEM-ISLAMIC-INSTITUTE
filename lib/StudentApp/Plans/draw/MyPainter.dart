import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sprint1/StudentApp/Plans/draw/shapes.dart';


class MyPainter extends CustomPainter {
  final List<DrawnShape> shapes;
  final List<Offset> currentPoints;
  final Color currentColor;
  final double strokeWidth;
  final String shape;
  final bool filled;

  MyPainter(this.shapes, this.currentPoints, this.currentColor, this.strokeWidth, this.shape, this.filled);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = currentColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth
      ..style = filled ? PaintingStyle.fill : PaintingStyle.stroke;

    for (var shape in shapes) {
      _drawShape(canvas, shape);
    }

    if (shape == "freehand") {
      canvas.drawPoints(PointMode.polygon, currentPoints, paint);
    } else if (currentPoints.length == 2) {
      _drawShape(canvas, DrawnShape(points: currentPoints, color: currentColor, strokeWidth: strokeWidth, shapeType: shape, filled: filled));
    }
  }

  void _drawShape(Canvas canvas, DrawnShape shape) {
    Paint paint = Paint()
      ..color = shape.color
      ..strokeCap = StrokeCap.round
      ..strokeWidth = shape.strokeWidth
      ..style = shape.filled ? PaintingStyle.fill : PaintingStyle.stroke;

    if (shape.shapeType == "freehand") {
      canvas.drawPoints(PointMode.polygon, shape.points, paint);
    } else if (shape.shapeType == "circle") {
      Offset center = shape.points.first;
      double radius = (shape.points.last - shape.points.first).distance / 2;
      canvas.drawCircle(center, radius, paint);
    } else if (shape.shapeType == "square") {
      Rect rect = Rect.fromPoints(shape.points.first, shape.points.last);
      canvas.drawRect(rect, paint);
    } else if (shape.shapeType == "triangle") {
      Offset p1 = shape.points.first;
      Offset p2 = Offset(shape.points.last.dx, shape.points.first.dy);
      Offset p3 = shape.points.last;
      Path path = Path()
        ..moveTo(p1.dx, p1.dy)
        ..lineTo(p2.dx, p2.dy)
        ..lineTo(p3.dx, p3.dy)
        ..close();
      canvas.drawPath(path, paint);
    }
  }

  bool _isPointInsideShape(Offset point, DrawnShape shape) {
    if (shape.shapeType == 'circle') {
      Offset center = shape.points.first;
      double radius = (shape.points.last - shape.points.first).distance / 2;
      return (point - center).distance <= radius;
    } else if (shape.shapeType == 'square') {
      Offset topLeft = shape.points.first;
      Offset bottomRight = shape.points.last;
      return point.dx >= topLeft.dx && point.dx <= bottomRight.dx && point.dy >= topLeft.dy && point.dy <= bottomRight.dy;
    } else if (shape.shapeType == 'triangle') {
      Offset p1 = shape.points.first;
      Offset p2 = Offset(shape.points.last.dx, shape.points.first.dy);
      Offset p3 = shape.points.last;

      double area = _triangleArea(p1, p2, p3);
      double area1 = _triangleArea(point, p2, p3);
      double area2 = _triangleArea(p1, point, p3);
      double area3 = _triangleArea(p1, p2, point);

      return (area - (area1 + area2 + area3)).abs() < 0.01;
    }
    return false;
  }

  double _triangleArea(Offset p1, Offset p2, Offset p3) {
    return (p1.dx * (p2.dy - p3.dy) + p2.dx * (p3.dy - p1.dy) + p3.dx * (p1.dy - p2.dy)).abs() / 2.0;
  }


  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
