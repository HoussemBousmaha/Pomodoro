import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:tomatoro/screens/home_screen/clock_painter.dart';

class Clock extends StatefulWidget {
  const Clock({Key? key}) : super(key: key);

  @override
  State<Clock> createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  double angle = math.pi * 5 / 6;
  int time = 25;

  void getAngle(DragUpdateDetails details) {
    final position = details.localPosition;
    final x = (position.dx - 150);
    final y = (position.dy - 150);
    final tan = y / x;
    angle = math.atan(tan);
    if (x <= 0 && y <= 0) {
      angle += math.pi;
    } else if (y >= 0 && x <= 0) {
      angle += math.pi;
    }

    angle += math.pi * .5;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          // getting the angle from the gesture.
          getAngle(details);

          // converting the angle to correct time in minutes.
          time = 30 * angle ~/ math.pi;
        });
      },
      child: CustomPaint(
        size: const Size(300, 300),
        painter: ClockPainter(angle: angle),
        child: Container(
          height: 300,
          width: 300,
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$time',
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Text('min.'),
            ],
          ),
        ),
      ),
    );
  }
}
