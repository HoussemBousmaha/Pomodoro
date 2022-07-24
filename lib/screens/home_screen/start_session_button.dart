import 'package:flutter/material.dart';
import 'package:tomatoro/screens/session_screen/session_screen.dart';

class StartSessionButton extends StatelessWidget {
  const StartSessionButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (BuildContext context, _, __) => const SessionScreen(),
            transitionsBuilder: (
              _,
              Animation<double> animation,
              __,
              Widget child,
            ) =>
                FadeTransition(opacity: animation, child: child),
          ),
        );
      },
      child: Container(
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
    );
  }
}
