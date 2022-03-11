//Copy this CustomPainter code to the Bottom of the File
import 'package:flutter/material.dart';

//Copy this CustomPainter code to the Bottom of the File
class Palmar extends CustomPainter {
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
    path_2.moveTo(size.width * 0.2653784, size.height * 0.2708786);
    path_2.cubicTo(
        size.width * 0.2506441,
        size.height * 0.2956522,
        size.width * 0.2341385,
        size.height * 0.3212862,
        size.width * 0.2156200,
        size.height * 0.3476449);
    path_2.cubicTo(
        size.width * 0.1871981,
        size.height * 0.3881793,
        size.width * 0.1573269,
        size.height * 0.4258152,
        size.width * 0.1272142,
        size.height * 0.4605072);
    path_2.cubicTo(
        size.width * 0.1108696,
        size.height * 0.4812953,
        size.width * 0.07020934,
        size.height * 0.5401721,
        size.width * 0.09597424,
        size.height * 0.6149909);
    path_2.cubicTo(
        size.width * 0.1209340,
        size.height * 0.6875906,
        size.width * 0.1938003,
        size.height * 0.7329257,
        size.width * 0.2226248,
        size.height * 0.7491395);
    path_2.cubicTo(
        size.width * 0.2466989,
        size.height * 0.7604167,
        size.width * 0.3642512,
        size.height * 0.8130888,
        size.width * 0.5318035,
        size.height * 0.8046649);
    path_2.cubicTo(
        size.width * 0.6533816,
        size.height * 0.7985054,
        size.width * 0.7351852,
        size.height * 0.7635417,
        size.width * 0.7652979,
        size.height * 0.7491395);
    path_2.cubicTo(
        size.width * 0.7963768,
        size.height * 0.7329257,
        size.width * 0.8770531,
        size.height * 0.6865489,
        size.width * 0.9067633,
        size.height * 0.6103714);
    path_2.cubicTo(
        size.width * 0.9398551,
        size.height * 0.5253170,
        size.width * 0.8880837,
        size.height * 0.4579257,
        size.width * 0.8706119,
        size.height * 0.4373641);
    path_2.cubicTo(
        size.width * 0.8513688,
        size.height * 0.4154891,
        size.width * 0.8321256,
        size.height * 0.3915761,
        size.width * 0.8138486,
        size.height * 0.3656703);
    path_2.cubicTo(
        size.width * 0.7901771,
        size.height * 0.3320652,
        size.width * 0.7716586,
        size.height * 0.3002264,
        size.width * 0.7570853,
        size.height * 0.2708333);
    path_2.cubicTo(
        size.width * 0.7539452,
        size.height * 0.2679348,
        size.width * 0.7259259,
        size.height * 0.2432518,
        size.width * 0.6707729,
        size.height * 0.2400815);
    path_2.cubicTo(
        size.width * 0.6205314,
        size.height * 0.2371830,
        size.width * 0.5863929,
        size.height * 0.2542572,
        size.width * 0.5811594,
        size.height * 0.2569746);
    path_2.cubicTo(
        size.width * 0.5749597,
        size.height * 0.2598279,
        size.width * 0.5503221,
        size.height * 0.2705163,
        size.width * 0.5141707,
        size.height * 0.2699275);
    path_2.cubicTo(
        size.width * 0.4814815,
        size.height * 0.2693841,
        size.width * 0.4595813,
        size.height * 0.2600543,
        size.width * 0.4528986,
        size.height * 0.2569746);
    path_2.cubicTo(
        size.width * 0.4485507,
        size.height * 0.2550272,
        size.width * 0.3912238,
        size.height * 0.2305707,
        size.width * 0.3266506,
        size.height * 0.2435688);
    path_2.cubicTo(
        size.width * 0.2921095,
        size.height * 0.2505435,
        size.width * 0.2727858,
        size.height * 0.2647192,
        size.width * 0.2653784,
        size.height * 0.2708786);
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
