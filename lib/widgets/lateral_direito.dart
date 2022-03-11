//Copy this CustomPainter code to the Bottom of the File
import 'package:flutter/material.dart';

//Copy this CustomPainter code to the Bottom of the File
class LateralDireito extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.6272947, size.height * 0.6117301);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.2854267, size.height * 0.5057518);

    Paint paint_1_stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.004830918;
    paint_1_stroke.color = Color(0xff0019FF).withOpacity(1.0);
    canvas.drawPath(path_1, paint_1_stroke);

    Path path_2 = Path();
    path_2.moveTo(size.width * 0.7192432, size.height * 0.5410326);
    path_2.cubicTo(
        size.width * 0.7006441,
        size.height * 0.5209692,
        size.width * 0.6760870,
        size.height * 0.4981884,
        size.width * 0.6435588,
        size.height * 0.4746377);
    path_2.cubicTo(
        size.width * 0.6227053,
        size.height * 0.4595109,
        size.width * 0.6017713,
        size.height * 0.4464221,
        size.width * 0.5818841,
        size.height * 0.4350996);
    path_2.cubicTo(
        size.width * 0.5652979,
        size.height * 0.4331069,
        size.width * 0.5376006,
        size.height * 0.4310236,
        size.width * 0.5041868,
        size.height * 0.4344203);
    path_2.cubicTo(
        size.width * 0.4682770,
        size.height * 0.4380435,
        size.width * 0.4421900,
        size.height * 0.4463315,
        size.width * 0.4276973,
        size.height * 0.4517663);
    path_2.cubicTo(
        size.width * 0.4159420,
        size.height * 0.4521286,
        size.width * 0.3760870,
        size.height * 0.4541214,
        size.width * 0.3438003,
        size.height * 0.4718750);
    path_2.cubicTo(
        size.width * 0.3268921,
        size.height * 0.4812047,
        size.width * 0.3184380,
        size.height * 0.4913496,
        size.width * 0.3141707,
        size.height * 0.4977808);
    path_2.cubicTo(
        size.width * 0.3219002,
        size.height * 0.5067935,
        size.width * 0.3349436,
        size.height * 0.5193841,
        size.width * 0.3565217,
        size.height * 0.5317482);
    path_2.cubicTo(
        size.width * 0.3731884,
        size.height * 0.5413496,
        size.width * 0.3900161,
        size.height * 0.5479167,
        size.width * 0.4033011,
        size.height * 0.5523098);
    path_2.cubicTo(
        size.width * 0.4508857,
        size.height * 0.5567935,
        size.width * 0.5140902,
        size.height * 0.5599185,
        size.width * 0.5876006,
        size.height * 0.5557971);
    path_2.cubicTo(
        size.width * 0.6388084,
        size.height * 0.5529438,
        size.width * 0.6830918,
        size.height * 0.5471920,
        size.width * 0.7192432,
        size.height * 0.5410326);
    path_2.close();

    Paint paint_2_stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.008856683;
    paint_2_stroke.color = Color(0xff00EDFF).withOpacity(1.0);
    canvas.drawPath(path_2, paint_2_stroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
