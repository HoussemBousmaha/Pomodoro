import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final sessionTimeProvider = StateProvider<int>((ref) {
  return 25;
});

class SessionScreen extends HookConsumerWidget {
  const SessionScreen({Key? key}) : super(key: key);

  static const routeName = '/session-screen/';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final time = ref.watch(sessionTimeProvider);
    final controller = useAnimationController(
      duration: Duration(minutes: time),
    );

    final angle = useState<double>(0);

    useEffect(() {
      controller.forward();
      controller.addListener(() {
        final alpha = controller.value * 360;
        angle.value = alpha;
      });
      return null;
    }, []);

    final size = MediaQuery.of(context).size;
    final canvasSize = Size(size.width, size.height);
    return Scaffold(
      backgroundColor: const Color(0xFF562B2B),
      body: CustomPaint(
        painter: TimePassingPainter(angle: angle.value),
        size: canvasSize,
        child: Container(
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              height: 100,
              width: 100,
              decoration: const BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Container(
                height: 20,
                width: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

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
