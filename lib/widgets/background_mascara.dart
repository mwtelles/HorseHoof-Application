//Copy this CustomPainter code to the Bottom of the File
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

//Copy this CustomPainter code to the Bottom of the File
class BackgroundMascara extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * -0.2574074, size.height * 0.8197011);

    Path path_1 = Path();
    path_1.moveTo(size.width * -0.5992754, size.height * 0.7137228);

    Paint paint_1_stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.004830918;
    paint_1_stroke.color = const Color(0xff0019FF).withOpacity(1.0);
    canvas.drawPath(path_1, paint_1_stroke);

    Paint paint_2_fill = Paint()..style = PaintingStyle.fill;
    paint_2_fill.shader = ui.Gradient.radial(
        Offset(size.width * 0.5000000, size.height * 0.5000000),
        size.width * 0.7211531, [
      const Color(0xff000000).withOpacity(0),
      const Color(0xff000000).withOpacity(1.0)
    ], [
      0,
      1
    ]);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint_2_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
