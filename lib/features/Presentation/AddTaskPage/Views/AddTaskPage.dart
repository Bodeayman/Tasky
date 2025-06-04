import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasky/core/utils/constants.dart';
import 'package:tasky/core/utils/refresh_token.dart';
import 'package:tasky/core/utils/shared_prefs_service.dart';
import 'package:tasky/core/utils/url.dart';
import 'package:tasky/features/Presentation/HomePage/Presentation/Manager/TaskCubit.dart';
import 'package:tasky/features/Presentation/AddTaskPage/Views/Widgets/add_task_button.dart';
import 'package:tasky/features/Presentation/AddTaskPage/Views/Widgets/calender_button.dart';
import 'package:tasky/core/components/priority_choose.dart';
import 'package:tasky/features/Presentation/HomePage/Presentation/Views/homePage.dart';
import 'package:tasky/core/utils/style/colors.dart';
import 'package:tasky/core/utils/style/inputStyle.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  @override
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add New Task",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(height: 10),
              const AddTaskButton(),
              Container(height: 20),
              SizedBox(
                child: Row(
                  children: [
                    Container(width: 10),
                    const Text(
                      "Task Title",
                    ),
                  ],
                ),
              ),
              Container(height: 10),
              SizedBox(
                height: averageHeight,
                child: TextField(
                  controller: titleController,
                  decoration: inputStyle.copyWith(
                      hintText: "Enter title here...",
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(width: 1.0),
                          borderRadius: BorderRadius.circular(kborderSize))),
                ),
              ),
              Container(height: 20),
              SizedBox(
                child: Row(
                  children: [
                    Container(width: 10),
                    const Text(
                      "Task Description",
                    ),
                  ],
                ),
              ),
              Container(height: 10),
              TextField(
                controller: descriptionController,
                maxLines: 5,
                decoration: inputStyle.copyWith(
                    hintText: "Enter description here....",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(kborderSize))),
              ),
              Container(height: 20),
              SizedBox(
                child: Row(
                  children: [
                    Container(width: 10),
                    const Text(
                      "Priority",
                    ),
                  ],
                ),
              ),
              Container(height: 10),
              const PriorityChoose(
                PriorityChooseActive: true,
              ),
              Container(height: 20),
              SizedBox(
                child: Row(
                  children: [
                    Container(width: 10),
                    const Text(
                      "Due Date",
                    ),
                  ],
                ),
              ),
              Container(height: 10),
              const CalendarButton(),
              Container(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: MaterialButton(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 110, vertical: 20),
                        color: mainColor,
                        onPressed: () async {
                          try {
                            final token = await getAccessToken();
                            debugPrint(titleController.text);
                            debugPrint(descriptionController.text);

                            final response = await http.post(
                              Uri.parse('$baseUrl/todos'),
                              body: {
                                "image": "path.png",
                                "dueDate": "2024-05-15",
                                "priority": "low",
                                "title": titleController.text,
                                "desc": descriptionController.text,
                              },
                              headers: {
                                'Authorization': 'Bearer $token',
                              },
                            );
                            if (response.statusCode == 401) {
                              refreshAccessToken();
                              throw Exception(
                                  "Failed to Add another Task, Please Try again");
                            }
                            context.read<TaskCubit>().fetchTasks();
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Added Task Successfully")));
                            Navigator.of(context).pop();
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.toString())));
                          }
                        },
                        child: const Text(
                          "Add Task",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

// {
//     "image"  : "path.png",
//     "title" : "title",
//     "desc" : "desc",
//     "priority" : "low",//low , medium , high
//     "dueDate" : "2024-05-15"
// }
