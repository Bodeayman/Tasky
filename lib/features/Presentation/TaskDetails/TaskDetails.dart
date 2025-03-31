import 'package:flutter/material.dart';
import 'package:tasky/features/Presentation/HomePage/homePage.dart';
import 'package:tasky/core/utils/style/colors.dart';
import 'package:tasky/features/Presentation/TaskDetails/Widgets/task_options.dart';

class TaskDetails extends StatefulWidget {
  const TaskDetails({super.key});

  @override
  State<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  String infoTask =
      "This shit is desinged for super shopes. By using this application they can enlist all their products in one place and can delivers . Customers will get a one-stop. solution for their daily shopping";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                );
              },
            ),
            const Text(
              "Task details",
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
        actions: const [TaskOptionsActionButton()],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Container(height: 20),
            Expanded(
              child: SizedBox(
                height: 200,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.amber,
                  ),
                  child: const Center(
                    child: Text("Placholder for the image here"),
                  ),
                ),
              ),
            ),
            Container(height: 20),
            Expanded(
              child: Column(
                children: [
                  const Text(
                    "Grocery Shopping App",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  Container(
                    height: 10,
                  ),
                  Text(
                    infoTask,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Container(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: lightPurple,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    height: 80,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("End date"),
                              Text(
                                "30 June,2022",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Icon(Icons.date_range),
                        ],
                      ),
                    ),
                  ),
                  Container(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: lightPurple,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    height: 80,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Inprogress",
                            style: TextStyle(
                              fontSize: 20,
                              color: mainColor,
                            ),
                          ),
                          Icon(Icons.arrow_downward, color: mainColor),
                        ],
                      ),
                    ),
                  ),
                  Container(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: lightPurple,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    height: 80,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.flag, size: 40, color: mainColor),
                              Container(width: 5),
                              Text(
                                "Medium Priority",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: mainColor,
                                ),
                              ),
                            ],
                          ),
                          Icon(Icons.arrow_downward, color: mainColor),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
