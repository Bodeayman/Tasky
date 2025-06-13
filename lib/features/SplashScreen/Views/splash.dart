import 'package:flutter/material.dart';
import 'package:tasky/core/utils/refresh_token.dart';
import 'package:tasky/core/utils/shared_prefs_service.dart';
import 'package:tasky/features/HomePage/Presentation/Views/homePage.dart';
import 'package:tasky/features/IntroPage/Views/intro.dart';
import 'package:tasky/features/PhoneLogin/Presentation/Views/phoneLogin.dart'; // Make sure this path is correct

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool _visible = true;

  @override
  void initState() {
    super.initState();
    _startFading();
    _checkOnBoarding();
  }

  void _startFading() async {
    while (mounted) {
      await Future.delayed(const Duration(seconds: 1));
      if (!mounted) return;
      setState(() {
        _visible = !_visible;
      });
    }
  }

  Future<void> _checkOnBoarding() async {
    bool signedInBefore = await onBoarding();
    if (!signedInBefore) {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const IntroductionPage(),
          ),
        );
      }
    }
    bool result = await refreshAccessToken();
    if (result != false) {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      }
    } else {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const Phonelogin(),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF5F33E1), // Purple background color
      body: Center(
        child: AnimatedOpacity(
          opacity: _visible ? 1.0 : 0.0,
          duration: const Duration(seconds: 1),
          child: Image.asset(
            "assets/SPLASH.png",
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
