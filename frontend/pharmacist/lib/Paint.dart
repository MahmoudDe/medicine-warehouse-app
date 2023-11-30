import 'package:flutter/material.dart';

class WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.cyan.shade700;
    paint.style = PaintingStyle.fill;

    var path = Path();

    path.lineTo(0, size.height / 5);
    path.quadraticBezierTo(size.width / 4, size.height / 2, size.width / 2, size.height / 4);
    path.quadraticBezierTo(size.width * 3 / 4, 0, size.width, size.height / 5);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
