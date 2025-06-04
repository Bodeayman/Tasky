import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasky/features/Presentation/HomePage/Data/Repo/HomeRepo.dart';
import 'package:tasky/features/Presentation/HomePage/Presentation/Manager/TaskCubit.dart';
import 'package:tasky/features/Presentation/ProfilePage/Data/Repo/ProfileRepo.dart';
import 'package:tasky/features/Presentation/ProfilePage/Presentation/Manager/profile_loading_cubit.dart';

import 'package:tasky/features/Presentation/SplashScreen/Views/splash.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TaskCubit(HomeRepo())..fetchTasks(),
        ),
        BlocProvider(
          create: (context) =>
              ProfileLoadingCubit(ProfileRepo())..fetchingUsersData(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(textTheme: GoogleFonts.dmSansTextTheme()),
        home: const SplashPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
