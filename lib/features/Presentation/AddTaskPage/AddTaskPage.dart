import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasky/core/utils/constants.dart';
import 'package:tasky/features/Presentation/AddTaskPage/Widgets/add_task_button.dart';
import 'package:tasky/features/Presentation/AddTaskPage/Widgets/calender_button.dart';
import 'package:tasky/core/components/priority_choose.dart';
import 'package:tasky/features/Presentation/HomePage/homePage.dart';
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
              const PriorityChoose(),
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
              const CalenderButton(),
              Container(
                height: 20,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(kborderSize),
                child: MaterialButton(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 110, vertical: 20),
                  color: mainColor,
                  onPressed: () {
                    setState(
                      () {},
                    );
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                    );
                  },
                  child: const Text(
                    "Add Task",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
