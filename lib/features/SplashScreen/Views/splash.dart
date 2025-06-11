import 'package:flutter/material.dart';
import 'package:tasky/core/utils/refresh_token.dart';
import 'package:tasky/core/utils/shared_prefs_service.dart';
import 'package:tasky/features/HomePage/Presentation/Views/homePage.dart';
import 'package:tasky/features/PhoneLogin/Presentation/Views/phoneLogin.dart'; // Make sure this path is correct

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    _checkOnBoarding();

    super.initState();
  }

  Future<void> _checkOnBoarding() async {
    bool refreshTokenFound = await refreshAccessToken();
    debugPrint(refreshTokenFound.toString());
    if (refreshTokenFound) {
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
        child: Image.asset(
          "assets/SPLASH.png",
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
