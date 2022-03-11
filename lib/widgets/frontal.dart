//Copy this CustomPainter code to the Bottom of the File
import 'package:flutter/material.dart';

//Copy this CustomPainter code to the Bottom of the File
class Frontal extends CustomPainter {
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
    path_2.moveTo(size.width * 0.3920290, size.height * 0.4610054);
    path_2.cubicTo(
        size.width * 0.3884058,
        size.height * 0.4800725,
        size.width * 0.3842995,
        size.height * 0.4995471,
        size.width * 0.3797101,
        size.height * 0.5193841);
    path_2.cubicTo(
        size.width * 0.3743961,
        size.height * 0.5421649,
        size.width * 0.3685990,
        size.height * 0.5643569,
        size.width * 0.3624799,
        size.height * 0.5860054);
    path_2.cubicTo(
        size.width * 0.3923510,
        size.height * 0.5931612,
        size.width * 0.4454911,
        size.height * 0.6033514,
        size.width * 0.5137681,
        size.height * 0.6030344);
    path_2.cubicTo(
        size.width * 0.5778583,
        size.height * 0.6027174,
        size.width * 0.6279388,
        size.height * 0.5932971,
        size.width * 0.6572464,
        size.height * 0.5863678);
    path_2.cubicTo(
        size.width * 0.6524155,
        size.height * 0.5644928,
        size.width * 0.6474235,
        size.height * 0.5426630,
        size.width * 0.6424316,
        size.height * 0.5207880);
    path_2.cubicTo(
        size.width * 0.6374396,
        size.height * 0.4991395,
        size.width * 0.6324477,
        size.height * 0.4775362,
        size.width * 0.6272947,
        size.height * 0.4559330);
    path_2.cubicTo(
        size.width * 0.6121578,
        size.height * 0.4543025,
        size.width * 0.5931562,
        size.height * 0.4529891,
        size.width * 0.5712560,
        size.height * 0.4531703);
    path_2.cubicTo(
        size.width * 0.5463768,
        size.height * 0.4533967,
        size.width * 0.5252013,
        size.height * 0.4554801,
        size.width * 0.5089372,
        size.height * 0.4577899);
    path_2.cubicTo(
        size.width * 0.4929952,
        size.height * 0.4557518,
        size.width * 0.4731884,
        size.height * 0.4540308,
        size.width * 0.4504026,
        size.height * 0.4536232);
    path_2.cubicTo(
        size.width * 0.4284219,
        size.height * 0.4532609,
        size.width * 0.4091787,
        size.height * 0.4542572,
        size.width * 0.3933977,
        size.height * 0.4556159);
    path_2.cubicTo(
        size.width * 0.3929147,
        size.height * 0.4573822,
        size.width * 0.3924316,
        size.height * 0.4591938,
        size.width * 0.3920290,
        size.height * 0.4610054);
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
