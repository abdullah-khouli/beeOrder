import 'dart:ui';
import 'package:flutter/material.dart';

class CirclePainter extends CustomPainter {
  final _paint = Paint()
    ..color = Color(0XFFEF6C00)
    ..strokeWidth = 2
    // Use [PaintingStyle.fill] if you want the circle to be filled.
    ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawOval(
      Rect.fromLTWH(0, 0, size.width, size.height),
      _paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

Widget buildCircle(BuildContext context) {
  return CustomPaint(
    size: Size(6, 6),
    painter: CirclePainter(),
  );
}
