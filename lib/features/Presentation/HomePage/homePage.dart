import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/utils/pageControllerHandler.dart';
import 'package:tasky/cubits/page_cubit.dart';
import 'package:tasky/features/Presentation/AddTaskPage/AddTaskPage.dart';
import 'package:tasky/features/Presentation/HomePage/AlltasksPage.dart';
import 'package:tasky/features/Presentation/HomePage/Widgets/allTabs.dart';
import 'package:tasky/features/Presentation/HomePage/Widgets/fab.dart';
import 'package:tasky/features/Presentation/HomePage/finishedTasksPage.dart';
import 'package:tasky/features/Presentation/HomePage/inProgressTasksPage.dart';
import 'package:tasky/features/Presentation/HomePage/waitingTasksPage.dart';
import 'package:tasky/features/Presentation/PhoneLogin/phoneLogin.dart';
import 'package:tasky/features/Presentation/ProfilePage/profilePage.dart';

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
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const Phonelogin(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              "My Tasks",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.start,
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
