import 'dart:math' as math;

import 'package:flutter/material.dart';

class TimePassingPainter extends CustomPainter {
  final double angle;
  TimePassingPainter({required this.angle});

  @override
  void paint(Canvas canvas, Size size) {
    const center = Offset(0, 0);
    Paint paint = Paint()..color = const Color(0xFF724246);

    canvas.translate(size.width / 2, size.height / 2);

    final radius = 2 * math.max(size.height, size.width).toDouble();
    canvas.drawArc(
      Rect.fromCenter(
        center: center,
        width: radius,
        height: radius,
      ),
      -math.pi / 2,
      math.pi * angle / 180,
      true,
      paint,
    );

    // canvas.drawCircle(center, 50, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
