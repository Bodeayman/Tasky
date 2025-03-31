import 'package:flutter/material.dart';
import 'package:tasky/features/Presentation/IntroPage/intro.dart'; // Make sure this path is correct

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    // Delay for 3 seconds and navigate to the IntroductionPage
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const IntroductionPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF5F33E1), // Purple background color
      body: Center(
        child: Image.asset(
          "assets/splash.png",
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
