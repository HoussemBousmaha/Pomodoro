import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tomatoro/screens/home_screen/home_screen.dart';
import 'package:tomatoro/screens/session_screen/session_screen.dart';
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
      routes: {
        SessionScreen.routeName: (context) => const SessionScreen(),
      },
    );
  }
}
