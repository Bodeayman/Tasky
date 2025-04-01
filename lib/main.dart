import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:tasky/features/Presentation/AddTaskPage/AddTaskPage.dart';
import 'package:tasky/features/Presentation/AddTaskPage/Widgets/add_task_button.dart';
import 'package:tasky/features/Presentation/HomePage/homePage.dart';
import 'package:tasky/features/Presentation/IntroPage/intro.dart';
import 'package:tasky/core/sharedPrefs/DataFun.dart';
import 'package:tasky/features/Presentation/ProfilePage/profilePage.dart';

import 'package:tasky/features/Presentation/SplashScreen/splash.dart';
import 'package:tasky/features/Presentation/TaskDetails/TaskDetails.dart';

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
      theme: ThemeData(fontFamily: 'Varela'),
      home: const SplashPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
