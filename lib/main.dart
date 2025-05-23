import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:tasky/features/Presentation/SplashScreen/splash.dart';

Future<void> main() async {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(textTheme: GoogleFonts.dmSansTextTheme()),
      home: const SplashPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
