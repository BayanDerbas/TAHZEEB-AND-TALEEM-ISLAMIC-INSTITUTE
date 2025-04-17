import 'dart:ui';

class DrawnShape {
  final String shapeType;
  final List<Offset> points;
  final Color color;
  final double strokeWidth;
  final bool filled;

  DrawnShape({
    this.shapeType = 'freehand',
    required this.points,
    required this.color,
    required this.strokeWidth,
    this.filled = false,
  });

  // Method to convert DrawnShape object to a map
  Map<String, dynamic> toMap() {
    return {
      'shapeType': shapeType,
      'points': points.map((point) => {'dx': point.dx, 'dy': point.dy}).toList(),
      'color': color.value,
      'strokeWidth': strokeWidth,
      'filled': filled,
    };
  }

  // Method to create a DrawnShape object from a map
  factory DrawnShape.fromMap(Map<String, dynamic> map) {
    return DrawnShape(
      shapeType: map['shapeType'],
      points: List<Offset>.from(map['points'].map((point) => Offset(point['dx'], point['dy']))),
      color: Color(map['color']),
      strokeWidth: map['strokeWidth'],
      filled: map['filled'],
    );
  }
}
