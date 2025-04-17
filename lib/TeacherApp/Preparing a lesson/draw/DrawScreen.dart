
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import '../../../StudentApp/Plans/draw/MyPainter.dart';
import '../../../StudentApp/Plans/draw/shapes.dart';



class DrawingTeacher extends StatefulWidget {
  final int? index;
  const DrawingTeacher({super.key, this.index});
  @override
  _DrawingTeacherState createState() => _DrawingTeacherState();
}



class _DrawingTeacherState extends State<DrawingTeacher> {
  List<DrawnShape> drawnShapes = [];
  List<DrawnShape> undoneShapes = [];
  List<Offset> currentPoints = [];
  Color selectedColor = Colors.black;
  double strokeWidth = 4.0;
  String selectedShape = "freehand";
  bool filled = false; // متغير لتحديد ما إذا كان الشكل ممتلئًا أم لا
  int? selectedIndex; // لتحديد العنصر المحدد للحذف

  bool eraseByStrokeMode = false;
  bool eraseByAreaMode = false;
  List<Offset> erasePoints = [];

  @override
  void initState() {
    super.initState();
    if (widget.index != null) {
      _loadDrawing(widget.index!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text("Drawing App"),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_road_rounded),
        onPressed: () {
          setState(() {
            eraseByAreaMode = true;
            eraseByStrokeMode = false;
          });
            }
          ),
          IconButton(
            icon: const Icon(Icons.undo),
            onPressed: _undo,
          ),
          IconButton(
            icon: const Icon(Icons.redo),
            onPressed: _redo,
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: _clearAll,
          ),
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _save,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: GestureDetector(
                onPanUpdate: (details) {
                  setState(() {
                    if (eraseByStrokeMode || eraseByAreaMode) {
                      erasePoints.add(details.localPosition);
                    } else {
                      currentPoints.add(details.localPosition);
                      if (selectedShape != "freehand") {
                        currentPoints = [currentPoints.first, details.localPosition];
                      }
                    }
                  });
                },
                onPanEnd: (details) {
                  setState(() {
                    if (eraseByStrokeMode) {
                      _eraseByStroke();
                    } else if (eraseByAreaMode) {
                      _eraseByArea();
                    } else {
                      if (selectedShape == "freehand") {
                        drawnShapes.add(DrawnShape(
                          points: List.from(currentPoints),
                          color: selectedColor,
                          strokeWidth: strokeWidth,
                          filled: filled,
                        ));
                      } else {
                        _addShape(currentPoints);
                      }
                      currentPoints.clear();
                      undoneShapes.clear(); // تفريغ قائمة التراجع عند إضافة شكل جديد
                    }
                  });
                },
                child: CustomPaint(
                  painter: MyPainter(drawnShapes, currentPoints, selectedColor, strokeWidth, selectedShape, filled),
                  child: GestureDetector(
                    onTapUp: (details) {
                      setState(() {
                        Offset tapPosition = details.localPosition;
                        List<int> shapesToRemove = [];
                        for (int i = 0; i < drawnShapes.length; i++) {
                          if (_isPointInsideShape(tapPosition, drawnShapes[i])) {
                            shapesToRemove.add(i);
                          }
                        }
                        for (var index in shapesToRemove.reversed) {
                          drawnShapes.removeAt(index);
                        }
                      });
                    },
                    child: Container(),
                  ),
                ),
              )

          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: const Icon(Icons.brush, color: Colors.black),
                  onPressed: () {
                    setState(() {
                      selectedShape = "freehand";
                      eraseByStrokeMode = false;
                      eraseByAreaMode = false;
                    });
                  },
                ),
                PopupMenuButton<String>(
                  icon: const Icon(Icons.format_shapes, color: Colors.black), // الأيقونة الرئيسية لفتح القائمة
                  onSelected: (String shape) {
                    setState(() {
                      selectedShape = shape;
                      eraseByStrokeMode = false;
                      eraseByAreaMode = false;
                    });
                  },
                  itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                    PopupMenuItem<String>(
                      value: "circle",
                      child: Row(
                        children: [
                          Icon(
                            filled ? Icons.circle : Icons.circle_outlined,
                            color: Colors.black,
                          ),
                          const SizedBox(width: 8),
                          const Text("Circle"),
                        ],
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: "square",
                      child: Row(
                        children: [
                          Icon(
                            filled ? Icons.square_rounded : Icons.crop_square,
                            color: Colors.black,
                          ),
                          const SizedBox(width: 8),
                          const Text("Square"),
                        ],
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: "triangle",
                      child: Row(
                        children: [
                          Icon(
                            filled ? Icons.square_foot : Icons.change_history_outlined,
                            color: Colors.black,
                          ),
                          const SizedBox(width: 8),
                          const Text("Triangle"),
                        ],
                      ),
                    ),
                    const PopupMenuDivider(),
                    PopupMenuItem<String>(
                      enabled: false, // لمنع التفاعل مع هذا الخيار
                      child: StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Fill Shapes"),
                              Checkbox(
                                value: filled,
                                onChanged: (bool? value) {
                                  setState(() {
                                    filled = value!;
                                  });
                                  // تحديث الحالة الرئيسية
                                  this.setState(() {
                                    filled = value!;
                                  });
                                },
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  width: 150, // تعيين حجم محدود للشريط الانزلاقي
                  child: Slider(
                    min: 1.0,
                    max: 10.0,
                    value: strokeWidth,
                    onChanged: (value) {
                      setState(() {
                        strokeWidth = value;
                      });
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.color_lens, color: selectedColor),
                  onPressed: () {
                    _pickColor(context);
                  },
                ),
                Checkbox(
                  value: filled,
                  onChanged: (bool? value) {
                    setState(() {
                      filled = value!;
                    });
                  },
                  activeColor: selectedColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickColor(BuildContext context) async {
    Color newColor = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("اختر لونًا"),
        content: SingleChildScrollView(
          child: BlockPicker(
            pickerColor: selectedColor,
            onColorChanged: (color) {
              setState(() {
                selectedColor = color;
              });
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(selectedColor);
            },
            child: const Text("اختر"),
          ),
        ],
      ),
    );
  }

  void _undo() {
    if (drawnShapes.isNotEmpty) {
      setState(() {
        undoneShapes.add(drawnShapes.removeLast());
      });
    }
  }

  void _redo() {
    if (undoneShapes.isNotEmpty) {
      setState(() {
        drawnShapes.add(undoneShapes.removeLast());
      });
    }
  }

  void _clearAll() {
    setState(() {
      drawnShapes.clear();
      undoneShapes.clear();
    });
  }

  void _save() async {
    if (widget.index != null) {
      // إذا كنا نقوم بتعديل مخطط موجود
      _saveDrawing(); // احفظ الرسم في المخطط الحالي دون تغيير العنوان
    } else {
      // إذا كنا نقوم بإنشاء مخطط جديد
      String? title = await _getTitleFromUser(); // احصل على العنوان من المستخدم
      if (title != null) {
        _saveDrawing(title: title); // احفظ الرسم مع العنوان الجديد
      }
    }
  }

  Future<String?> _getTitleFromUser() async {
    String? title;
    await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('أدخل عنوان المخطط'),
          content: TextField(
            onChanged: (value) {
              title = value;
            },
            decoration: const InputDecoration(hintText: "أدخل العنوان هنا"),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('إلغاء'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('حفظ'),
              onPressed: () {
                Navigator.of(context).pop(title);
              },
            ),
          ],
        );
      },
    );
    return title;
  }


  void _saveDrawing({String? title}) {
    final box = Hive.box('drawingsBox');

    // تنسيق الوقت ليكون بالشكل المطلوب
    String formattedDate = DateFormat('h:mm a').format(DateTime.now());

    final drawingData = {
      'shapes': drawnShapes.map((shape) => shape.toMap()).toList(),
      'color': selectedColor.value,
      'strokeWidth': strokeWidth,
      'filled': filled,
      'title': title ?? box.getAt(widget.index!)['title'], // استخدم العنوان الحالي إذا لم يتم توفير عنوان جديد
      'date': formattedDate, // حفظ الوقت بالتنسيق الجديد
    };

    if (widget.index != null) {
      // تحديث الرسم الموجود
      box.putAt(widget.index!, drawingData);
    } else {
      // إنشاء رسم جديد
      box.add(drawingData);
    }
  }

  void _saveNewDrawing(String title) {
    final box = Hive.box('drawingsBox');
    final drawingData = {
      'title': title,
      'shapes': drawnShapes.map((shape) => shape.toMap()).toList(),
      'color': selectedColor.value,
      'strokeWidth': strokeWidth,
      'filled': filled,
    };
    box.add(drawingData);
  }

  void _updateDrawing(int index) {
    final box = Hive.box('drawingsBox');
    final drawingData = {
      'shapes': drawnShapes.map((shape) => shape.toMap()).toList(),
      'color': selectedColor.value,
      'strokeWidth': strokeWidth,
      'filled': filled,
    };
    box.putAt(index, drawingData);
  }

  void _addShape(List<Offset> points) {
    if (points.length < 2) return;

    Offset p1 = points.first;
    Offset p2 = points.last;

    switch (selectedShape) {
      case 'circle':
        drawnShapes.add(DrawnShape(
          shapeType: 'circle',
          points: [p1, p2],
          color: selectedColor,
          strokeWidth: strokeWidth,
          filled: filled,
        ));
        break;
      case 'square':
        drawnShapes.add(DrawnShape(
          shapeType: 'square',
          points: [p1, p2],
          color: selectedColor,
          strokeWidth:strokeWidth,
          filled: filled,
        ));
        break;
      case 'triangle':
        drawnShapes.add(DrawnShape(
          shapeType: 'triangle',
          points: [p1, p2],
          color: selectedColor,
          strokeWidth: strokeWidth,
          filled: filled,
        ));
        break;
      default:
        break;
    }
  }

  void _eraseByStroke() {
    if (erasePoints.isEmpty) return;

    List<int> shapesToRemove = [];

    for (int i = 0; i < drawnShapes.length; i++) {
      DrawnShape shape = drawnShapes[i];

      for (Offset point in erasePoints) {
        if (_isPointInsideShape(point, shape)) {
          shapesToRemove.add(i);
          break; // لا حاجة للتحقق من المزيد من النقاط بعد العثور على الشكل
        }
      }
    }

    setState(() {
      for (var index in shapesToRemove.reversed) {
        drawnShapes.removeAt(index);
      }
      erasePoints.clear();
    });
  }

  void _eraseByArea() {
    if (erasePoints.length < 2) return;

    Offset topLeft = erasePoints.first;
    Offset bottomRight = erasePoints.last;

    List<int> shapesToRemove = [];

    for (int i = 0; i < drawnShapes.length; i++) {
      DrawnShape shape = drawnShapes[i];

      if (_isShapeInsideArea(shape, topLeft, bottomRight)) {
        shapesToRemove.add(i);
      }
    }

    // Remove the shapes that are inside the erase area
    setState(() {
      for (var index in shapesToRemove.reversed) {
        drawnShapes.removeAt(index);
      }
      erasePoints.clear();
    });
  }

  bool _isPointInsideStroke(List<Offset> strokePoints, Offset point, double strokeWidth) {
    for (int i = 0; i < strokePoints.length - 1; i++) {
      Offset p1 = strokePoints[i];
      Offset p2 = strokePoints[i + 1];

      double distance = _distanceToSegment(point, p1, p2);
      if (distance <= strokeWidth) {
        return true;
      }
    }
    return false;
  }

  bool _isShapeInsideArea(DrawnShape shape, Offset topLeft, Offset bottomRight) {
    for (Offset point in shape.points) {
      if (point.dx >= topLeft.dx && point.dx <= bottomRight.dx && point.dy >= topLeft.dy && point.dy <= bottomRight.dy) {
        return true;
      }
    }
    return false;
  }

  double _distanceToSegment(Offset point, Offset p1, Offset p2) {
    double x = point.dx;
    double y = point.dy;
    double x1 = p1.dx;
    double y1 = p1.dy;
    double x2 = p2.dx;
    double y2 = p2.dy;

    double A = x - x1;
    double B = y - y1;
    double C = x2 - x1;
    double D = y2 - y1;

    double dot = A * C + B * D;
    double lenSq = C * C + D * D;
    double param = dot / lenSq;

    double xx, yy;

    if (param < 0) {
      xx = x1;
      yy = y1;
    } else if (param > 1) {
      xx = x2;
      yy = y2;
    } else {
      xx = x1 + param * C;
      yy = y1 + param * D;
    }

    double dx = x - xx;
    double dy = y - yy;
    return sqrt(dx * dx + dy * dy);
  }

  bool _isPointInsideShape(Offset point, DrawnShape shape) {
    if (shape.shapeType == 'circle') {
      Offset center = shape.points.first;
      double radius = (shape.points.last - shape.points.first).distance / 2;
      return (point - center).distance <= radius;
    } else if (shape.shapeType == 'square') {
      Offset topLeft = shape.points.first;
      Offset bottomRight = shape.points.last;
      return point.dx >= topLeft.dx && point.dx <= bottomRight.dx &&
          point.dy >= topLeft.dy && point.dy <= bottomRight.dy;
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

  void _loadDrawing(int index) {
    final box = Hive.box('drawingsBox');
    final drawingData = box.getAt(index);

    setState(() {
      drawnShapes = (drawingData['shapes'] as List)
         // .map((shapeData) => DrawnShape.fromMap(shapeData))
          .map((shapeData) => DrawnShape.fromMap(Map<String, dynamic>.from(shapeData as Map)))
          .toList();
      selectedColor = Color(drawingData['color']);
      strokeWidth = drawingData['strokeWidth'];
      filled = drawingData['filled'];
    });
  }

  double _triangleArea(Offset p1, Offset p2, Offset p3) {
    return (p1.dx * (p2.dy - p3.dy) + p2.dx * (p3.dy - p1.dy) + p3.dx * (p1.dy - p2.dy)).abs() / 2.0;
  }

}
