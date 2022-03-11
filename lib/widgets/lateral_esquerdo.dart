//Copy this CustomPainter code to the Bottom of the File
import 'package:flutter/material.dart';

//Copy this CustomPainter code to the Bottom of the File
class LateralEsquerdo extends CustomPainter {
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
    path_2.moveTo(size.width * 0.7145733, size.height * 0.4856431);
    path_2.cubicTo(
        size.width * 0.7041868,
        size.height * 0.4812953,
        size.width * 0.6916264,
        size.height * 0.4767210,
        size.width * 0.6767311,
        size.height * 0.4724638);
    path_2.cubicTo(
        size.width * 0.6510467,
        size.height * 0.4651268,
        size.width * 0.6271337,
        size.height * 0.4613225,
        size.width * 0.6084541,
        size.height * 0.4592844);
    path_2.cubicTo(
        size.width * 0.5823671,
        size.height * 0.4558424,
        size.width * 0.5532206,
        size.height * 0.4509964,
        size.width * 0.5221417,
        size.height * 0.4442482);
    path_2.cubicTo(
        size.width * 0.5004831,
        size.height * 0.4395380,
        size.width * 0.4806763,
        size.height * 0.4345109,
        size.width * 0.4629630,
        size.height * 0.4294384);
    path_2.cubicTo(
        size.width * 0.4415459,
        size.height * 0.4433424,
        size.width * 0.4187601,
        size.height * 0.4597826,
        size.width * 0.3962963,
        size.height * 0.4788496);
    path_2.cubicTo(
        size.width * 0.3771337,
        size.height * 0.4951540,
        size.width * 0.3613527,
        size.height * 0.5107790,
        size.width * 0.3482287,
        size.height * 0.5251812);
    path_2.cubicTo(
        size.width * 0.3741546,
        size.height * 0.5314764,
        size.width * 0.4131240,
        size.height * 0.5389493,
        size.width * 0.4620773,
        size.height * 0.5413496);
    path_2.cubicTo(
        size.width * 0.5172303,
        size.height * 0.5440670,
        size.width * 0.5623994,
        size.height * 0.5392663,
        size.width * 0.5911433,
        size.height * 0.5348732);
    path_2.cubicTo(
        size.width * 0.6106280,
        size.height * 0.5299366,
        size.width * 0.6337359,
        size.height * 0.5229620,
        size.width * 0.6581320,
        size.height * 0.5131341);
    path_2.cubicTo(
        size.width * 0.6816425,
        size.height * 0.5037591,
        size.width * 0.7002415,
        size.height * 0.4941123,
        size.width * 0.7145733,
        size.height * 0.4856431);
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
