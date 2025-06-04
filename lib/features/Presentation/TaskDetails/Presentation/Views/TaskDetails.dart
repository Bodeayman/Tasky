import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tasky/core/components/priority_choose.dart';
import 'package:tasky/features/Presentation/HomePage/Data/Models/Task.dart';
import 'package:tasky/core/utils/refresh_token.dart';
import 'package:tasky/core/utils/shared_prefs_service.dart';
import 'package:tasky/core/utils/style/colors.dart';
import 'package:tasky/core/utils/url.dart';

class TaskDetails extends StatelessWidget {
  const TaskDetails({super.key, required this.taskModel});
  final TaskModel taskModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Task details",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () => showMenu(
                    context: context,
                    items: [
                      const PopupMenuItem(
                          child: Text(
                        "Edit",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                      PopupMenuItem(
                          onTap: () async {
                            try {
                              final token = await getAccessToken();
                              final response = await http.delete(
                                Uri.parse('$baseUrl/todos/${taskModel.id}'),
                                headers: {
                                  'Authorization': 'Bearer $token',
                                },
                              );
                              if (response.statusCode == 401) {
                                await refreshAccessToken();
                                debugPrint(response.body);
                                throw Exception(
                                    "Failed to Delete the Task, Please Try again");
                              }
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text("Deleted Task Successfully")));
                              Navigator.of(context).pop();
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(e.toString())));
                            }
                          },
                          child: const Text("Delete",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange)))
                    ],
                    position: RelativeRect.fromLTRB(
                        MediaQuery.of(context).size.width, 50, 0, 0),
                  ))
        ],
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
                  Text(
                    taskModel.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  Container(
                    height: 10,
                  ),
                  Text(taskModel.desc,
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
                  const PriorityChoose(
                    PriorityChooseActive: false,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: Center(
                        child: QrImageView(
                      data: "",
                      version: QrVersions.auto,
                    )),
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
