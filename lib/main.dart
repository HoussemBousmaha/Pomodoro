import 'dart:io';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:window_size/window_size.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('Flutter Demo');
    setWindowMinSize(const Size(400, 450));
    setWindowMaxSize(Size.infinite);
  }
  runApp(const Tomatoro());
}

class Tomatoro extends StatelessWidget {
  const Tomatoro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      theme: ThemeData(
        textTheme: GoogleFonts.openSansTextTheme(),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFA65D5E),
            Color(0xFFA65D5E),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 30),
              const Clock(),
              const SizedBox(height: 30),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 40,
                    width: 170,
                    decoration: BoxDecoration(
                      color: const Color(0xFF55A11F),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 5,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.fast_forward, color: Colors.white),
                        SizedBox(width: 10),
                        Text(
                          'Start',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    height: 40,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.flag, color: Colors.white),
                        SizedBox(width: 10),
                        Text(
                          '0',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Clock extends StatefulWidget {
  const Clock({Key? key}) : super(key: key);

  @override
  State<Clock> createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  double angle = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
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
        });
      },
      child: Container(
        height: 300,
        width: 300,
        alignment: Alignment.center,
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
                  '25',
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
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  final double angle;

  ClockPainter({required this.angle});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.width / 2);
    const textStyle = TextStyle(color: Colors.black, fontSize: 15);
    final paint = Paint()
      ..color = Colors.pink
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20
      ..strokeCap = StrokeCap.round;

    final greyCirclePaint = Paint()..color = Colors.grey.shade300;
    final whiteCirclePaint = Paint()..color = Colors.white;

    canvas.drawCircle(const Offset(0, 0), size.height / 2, greyCirclePaint);
    canvas.drawCircle(const Offset(0, 0), size.height / 2 - 20, whiteCirclePaint);

    // Drawing the clock
    drawClockTimes(textStyle, size, canvas);

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
