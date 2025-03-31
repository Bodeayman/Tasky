import 'package:flutter/material.dart';
import 'package:tasky/features/Presentation/AddTaskPage/Widgets/add_task_button.dart';
import 'package:tasky/features/Presentation/HomePage/homePage.dart';
import 'package:tasky/main.dart';
import 'package:tasky/core/sharedPrefs/DataFun.dart';
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
              "Add New Task",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
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
              TextField(
                decoration: inputStyle.copyWith(
                  hintText: "Enter title here...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
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
                decoration:
                    inputStyle.copyWith(hintText: "Enter description here...."),
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
              MaterialButton(
                padding: const EdgeInsets.all(15),
                color: const Color.fromARGB(255, 188, 181, 208),
                onPressed: () {},
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
              TextField(
                keyboardType: TextInputType.datetime,
                decoration: inputStyle.copyWith(
                  suffixIcon: IconButton(
                    icon: Icon(Icons.date_range_rounded, color: mainColor),
                    onPressed: () {
                      showDatePicker(
                        context: context,
                        firstDate:
                            DateTime(DateTime.now().year, DateTime.now().month),
                        lastDate: DateTime(DateTime.now().year,
                            DateTime.now().month, DateTime.now().day),
                      );
                    },
                  ),
                  hintText: "choose due date...",
                ),
              ),
              Container(
                height: 20,
              ),
              MaterialButton(
                padding:
                    const EdgeInsets.symmetric(horizontal: 110, vertical: 20),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: const StadiumBorder(),
                color: const Color(0xFF5F33E1),
                onPressed: () {
                  setState(
                    () {
                      saveData(
                          titleController.text, descriptionController.text);
                      loadData();
                    },
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
            ],
          ),
        ),
      ),
    );
  }
}
