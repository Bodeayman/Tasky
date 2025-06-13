import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasky/core/utils/navigator_service.dart' show navigatorKey;
import 'package:tasky/features/AddTaskPage/Manager/adding_task_cubit.dart';
import 'package:tasky/features/HomePage/Data/Repo/HomeRepo.dart';
import 'package:tasky/features/HomePage/Presentation/Manager/TaskCubit.dart';
import 'package:tasky/features/PhoneLogin/Presentation/Views/phoneLogin.dart';
import 'package:tasky/features/PhoneLogin/Presentation/Views/phoneLoginForm.dart';
import 'package:tasky/features/ProfilePage/Data/Repo/ProfileRepo.dart';
import 'package:tasky/features/ProfilePage/Presentation/Manager/profile_loading_cubit.dart';

import 'package:tasky/features/SplashScreen/Views/splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TaskCubit(HomeRepo())..fetchInitialTasks(),
        ),
        BlocProvider(
          create: (context) => ProfileLoadingCubit(ProfileRepo()),
        ),
        BlocProvider(
          create: (context) => AddingTaskCubit(),
        ),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        theme: ThemeData(
          textTheme: GoogleFonts.dmSansTextTheme(),
        ),
        home: const SplashPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
