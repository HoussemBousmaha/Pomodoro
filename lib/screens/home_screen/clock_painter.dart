import 'dart:math' as math;

import 'package:flutter/material.dart';

class ClockPainter extends CustomPainter {
  final double angle;

  ClockPainter({required this.angle});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.width / 2);
    const textStyle = TextStyle(color: Colors.black, fontSize: 15);
    final paint = Paint()
      ..color = Colors.pink.shade200
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20
      ..strokeCap = StrokeCap.round;

    final greyCirclePaint = Paint()..color = Colors.grey.shade300;
    final whiteCirclePaint = Paint()..color = Colors.white;
    final pinkCirclePaint = Paint()..color = Colors.pink;

    // draw two Big circles in the middle
    canvas.drawCircle(const Offset(0, 0), size.height / 2, greyCirclePaint);
    canvas.drawCircle(const Offset(0, 0), size.height / 2 - 20, whiteCirclePaint);

    // Drawing the clock
    drawClockTimes(textStyle, size, canvas);

    // Drawing the minutes arc
    drawArc(canvas, size, paint, pinkCirclePaint);
  }

  void drawArc(Canvas canvas, Size size, Paint paint, Paint pinkCirclePaint) {
    canvas.drawArc(
      Rect.fromCenter(
        center: const Offset(0, 0),
        width: size.width - 20,
        height: size.height - 20,
      ),
      -math.pi / 2,
      angle,
      false,
      paint,
    );

    final x = 140 * math.cos(angle - math.pi / 2);
    final y = 140 * math.sin(angle - math.pi / 2);
    final position = Offset(x, y);

    canvas.drawCircle(
      position,
      20,
      pinkCirclePaint,
    );
  }

  void drawClockTimes(TextStyle textStyle, Size size, Canvas canvas) {
    for (int i = 0; i < 12; i++) {
      final textSpan = TextSpan(
        text: '${i * 5}',
        style: textStyle,
      );
      final textPainter = TextPainter(text: textSpan, textDirection: TextDirection.ltr);
      textPainter.layout(minWidth: 0, maxWidth: size.width);

      final x = ((size.width - 80) / 2) * math.sin(i * 30 * (math.pi / 180)) - textPainter.width / 2;
      final y = ((size.width - 80) / 2) * -math.cos(i * 30 * (math.pi / 180)) - textPainter.height / 2;

      final offset = Offset(x, y);
      textPainter.paint(canvas, offset);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
