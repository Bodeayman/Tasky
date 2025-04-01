import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasky/core/components/priority_choose.dart';
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
        title: const Text(
          "Task details",
          style: TextStyle(fontWeight: FontWeight.bold),
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
                child: Image.asset(
                  "assets/groceryHuge.png",
                ),
              ),
            ),
            Container(height: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  Text(infoTask,
                      style: GoogleFonts.dmSans(
                        color: const Color(0xff24252C),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 24 / 14,
                      )),
                  Container(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: priorityColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("End date",
                                  style: GoogleFonts.dmSans(fontSize: 9)),
                              Text(
                                "30 June,2022",
                                style: GoogleFonts.dmSans(fontSize: 14),
                              ),
                            ],
                          ),
                          SizedBox(
                              width: 24,
                              height: 24,
                              child: Image.asset("assets/calendarIcon.png",
                                  color: mainColor)),
                        ],
                      ),
                    ),
                  ),
                  Container(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: priorityColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
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
                          SizedBox(
                              width: 24,
                              height: 24,
                              child: Image.asset("assets/arrow_down.png",
                                  color: mainColor)),
                        ],
                      ),
                    ),
                  ),
                  Container(height: 10),
                  const PriorityChoose(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
