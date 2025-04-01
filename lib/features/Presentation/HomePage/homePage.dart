import 'package:flutter/material.dart';
import 'package:tasky/core/utils/pageControllerHandler.dart';
import 'package:tasky/features/Presentation/AddTaskPage/AddTaskPage.dart';
import 'package:tasky/features/Presentation/HomePage/AlltasksPage.dart';
import 'package:tasky/features/Presentation/HomePage/Widgets/allTabs.dart';
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
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const AddTaskPage(),
            ),
          );
        },
        backgroundColor: const Color(0xFF5F33E1),
        shape: const CircleBorder(),
        elevation: 10,
        child: const Icon(Icons.add, color: Colors.white),
      ),
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
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => ProfilePage(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const Phonelogin(),
                ),
              );
            },
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
          )
        ],
      ),
    );
  }
}
