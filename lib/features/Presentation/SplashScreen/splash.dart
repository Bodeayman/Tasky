import 'package:flutter/material.dart';
import 'package:tasky/core/utils/shared_prefs_service.dart';
import 'package:tasky/features/Presentation/HomePage/homePage.dart';
import 'package:tasky/features/Presentation/IntroPage/intro.dart';
import 'package:tasky/features/Presentation/PhoneLogin/phoneLogin.dart'; // Make sure this path is correct

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkOnBoarding();
  }

  Future<void> _checkOnBoarding() async {
    await Future.delayed(const Duration(seconds: 3));

    bool onBoard = await onBoarding();
    if (onBoard) {
      if (mounted) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomePage()));
      }
    } else {
      if (mounted) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const Phonelogin()));
      }
      setOnBoarding(true);
    }
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
