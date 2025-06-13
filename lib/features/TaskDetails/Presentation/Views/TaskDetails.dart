import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tasky/core/components/priority_choose.dart';
import 'package:tasky/core/components/progress_choose.dart';
import 'package:tasky/features/AddTaskPage/Views/AddTaskPage.dart';
import 'package:tasky/features/HomePage/Data/Models/Task.dart';
import 'package:tasky/core/utils/refresh_token.dart';
import 'package:tasky/core/utils/shared_prefs_service.dart';
import 'package:tasky/core/utils/style/colors.dart';
import 'package:tasky/core/utils/url.dart';
import 'package:tasky/features/HomePage/Presentation/Manager/TaskCubit.dart';
import 'package:tasky/features/TaskDetails/Presentation/Manager/Deletion.dart';

class TaskDetails extends StatelessWidget {
  const TaskDetails({super.key, required this.taskModel});
  final TaskModel taskModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          borderRadius: BorderRadius.circular(100),
          child: Image.asset("assets/arrow_left.png"),
          onTap: () => Navigator.of(context).pop(),
        ),
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
                PopupMenuItem(
                  onTap: () => {
                    debugPrint(taskModel.image),
                    debugPrint(taskModel.createdAt.toString()),
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AddTaskPage(
                          editingPageMode: true,
                          taskModel: taskModel,
                        ),
                      ),
                    ),
                  },
                  child: const Text(
                    "Edit",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                PopupMenuItem(
                  onTap: () async {
                    try {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Deleting Now..."),
                        ),
                      );
                      await DeleteTask(taskModel.id);
                      context.read<TaskCubit>().refreshTasks();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Deleted Task Successfully"),
                        ),
                      );
                      Navigator.of(context).pop();
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(e.toString()),
                        ),
                      );
                    }
                  },
                  child: const Text(
                    "Delete",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                )
              ],
              position: RelativeRect.fromLTRB(
                MediaQuery.of(context).size.width,
                50,
                0,
                0,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            SizedBox(
              height: 200,
              width: double.infinity,
              child: Image.network(
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return Hero(tag: taskModel.id, child: child);
                  }
                  return Hero(
                    tag: taskModel.id,
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        width: double.infinity,
                        height: 200, // adjust to your real size
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  );
                },
                "$baseUrl/images/${taskModel.image}",
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      color: Colors.red,
                      child: const Center(
                        child: Text(
                          "Error",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Text(
              taskModel.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 10),
            Text(
              taskModel.desc,
              style: GoogleFonts.dmSans(
                color: const Color.fromARGB(
                  166,
                  36,
                  37,
                  44,
                ),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 24 / 14,
              ),
            ),
            const SizedBox(height: 10),
            // Column(
            //   children: [
            //     Text(taskModel.desc),
            //     Text(taskModel.title),
            //     Text(taskModel.user),
            //     Text(taskModel.image),
            //     Text(taskModel.id),
            //     Text(taskModel.priority),
            //     Text(taskModel.status),
            //   ],
            // ),
            Container(
              decoration: BoxDecoration(
                color: priorityColor,
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "End date",
                        style: GoogleFonts.dmSans(fontSize: 9),
                      ),
                      Text(
                        taskModel.createdAt != null
                            ? "${taskModel.createdAt.year}-${taskModel.createdAt.month.toString().padLeft(2, '0')}-${taskModel.createdAt.day.toString().padLeft(2, '0')}"
                            : "No Date",
                        style: GoogleFonts.dmSans(fontSize: 14),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: Image.asset(
                      "assets/calendarIcon.png",
                      color: mainColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            ProgressChoose(
              progressChooseActive: false,
              value: taskModel.status,
            ),
            const SizedBox(height: 10),
            PriorityChoose(
              PriorityChooseActive: false,
              value: taskModel.priority,
            ),
            const SizedBox(height: 20),
            Center(
              child: QrImageView(
                data: taskModel.id,
                version: QrVersions.auto,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
