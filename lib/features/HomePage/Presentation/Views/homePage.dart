import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:tasky/core/utils/pageControllerHandler.dart';
import 'package:tasky/core/utils/refresh_token.dart';
import 'package:tasky/core/utils/shared_prefs_service.dart';
import 'package:tasky/core/utils/url.dart';
import 'package:tasky/features/HomePage/Presentation/Manager/page_cubit.dart';
import 'package:tasky/features/HomePage/Presentation/Views/AlltasksPage.dart';
import 'package:tasky/features/HomePage/Presentation/Views/Widgets/allTabs.dart';
import 'package:tasky/features/HomePage/Presentation/Views/Widgets/fab.dart';
import 'package:tasky/features/HomePage/Presentation/Views/finishedTasksPage.dart';
import 'package:tasky/features/HomePage/Presentation/Views/inProgressTasksPage.dart';
import 'package:tasky/features/HomePage/Presentation/Views/waitingTasksPage.dart';
import 'package:tasky/features/PhoneLogin/Presentation/Views/phoneLogin.dart';
import 'package:tasky/features/ProfilePage/Presentation/Views/profilePage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController pageController = PageController();
  PageControllerHandler? pageControllerHandler;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PageCubit(),
      child: Scaffold(
        floatingActionButton: const Fab(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 5,
            ),
            child: Text(
              "Logo",
              textAlign: TextAlign.end,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 19,
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                child: SizedBox(
                    height: 24,
                    width: 24,
                    child: Image.asset("assets/profileButton.png")),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                child: SizedBox(
                    height: 24,
                    width: 24,
                    child: Image.asset("assets/backbutton.png")),
                onTap: () async {
                  try {
                    final token = await getAccessToken();

                    final response = await http.post(
                      Uri.parse('$baseUrl/auth/logout'),
                      headers: {
                        'Authorization': 'Bearer $token',
                        'Content-Type': 'application/json',
                      },
                    );
                    if (response.statusCode != 200) {
                      await refreshAccessToken();
                      final token = await getAccessToken();

                      final response = await http.post(
                        Uri.parse('$baseUrl/auth/logout'),
                        headers: {
                          'Authorization': 'Bearer $token',
                          'Content-Type': 'application/json',
                        },
                      );
                      if (response.statusCode == 401) {
                        throw Exception("Failed to Logout, Try again please");
                      }
                    }

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Logged out"),
                      ),
                    );
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const Phonelogin(),
                      ),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          e.toString(),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "My Tasks",
                  style: TextStyle(
                    color: Color.fromARGB(
                      60,
                      36,
                      37,
                      44,
                    ),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
            Container(
              height: 10,
            ),
            const SizedBox(
              height: 40,
              child: AllTabsWidget(),
            ),
            Container(height: 15),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: BlocListener<PageCubit, PageState>(
                  listener: (context, state) {
                    if (state is PageInitial) {
                      pageController.jumpToPage(state.pageNumber);
                    }
                  },
                  child: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: pageController,
                    children: const [
                      Alltaskspage(),
                      Inprogresstaskspage(),
                      Waitingtaskspage(),
                      Finishedtaskspage(),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
