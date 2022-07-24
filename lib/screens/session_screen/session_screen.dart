import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tomatoro/providers.dart';
import 'package:tomatoro/screens/session_screen/time_passing_painter.dart';

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
      body: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
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
          Positioned(
            bottom: 50,
            child: Container(
              height: 60,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(40),
              ),
              alignment: Alignment.center,
              child: const Text(
                'Focus On Work',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
