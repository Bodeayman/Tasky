import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:tasky/core/components/progress_choose.dart';
import 'package:tasky/core/utils/constants.dart';
import 'package:tasky/core/utils/refresh_token.dart';
import 'package:tasky/core/utils/shared_prefs_service.dart';
import 'package:tasky/core/utils/url.dart';
import 'package:tasky/features/AddTaskPage/Manager/adding_task_cubit.dart';
import 'package:tasky/features/HomePage/Data/Models/Task.dart';
import 'package:tasky/features/HomePage/Presentation/Manager/TaskCubit.dart';
import 'package:tasky/features/AddTaskPage/Views/Widgets/add_task_button.dart';
import 'package:tasky/features/AddTaskPage/Views/Widgets/calender_button.dart';
import 'package:tasky/core/components/priority_choose.dart';
import 'package:tasky/core/utils/style/colors.dart';
import 'package:tasky/core/utils/style/inputStyle.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key, required this.editingPageMode, this.taskModel});
  final bool editingPageMode;
  final TaskModel? taskModel;
  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  @override
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  @override
  void initState() {
    debugPrint(widget.taskModel?.image);
    context.read<AddingTaskCubit>().setImagePath(widget.taskModel?.image);
    super.initState();

    titleController = widget.editingPageMode && widget.taskModel != null
        ? TextEditingController(text: widget.taskModel!.title)
        : TextEditingController();

    descriptionController = widget.editingPageMode && widget.taskModel != null
        ? TextEditingController(text: widget.taskModel!.desc)
        : TextEditingController();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          borderRadius: BorderRadius.circular(100),
          child: Image.asset("assets/arrow_left.png"),
          onTap: () => Navigator.of(context).pop(),
        ),
        title: Text(
          (!widget.editingPageMode) ? "Add New Task" : "Editing Task",
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                      borderRadius: BorderRadius.circular(kborderSize),
                    ),
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
                controller: descriptionController,
                maxLines: 5,
                decoration: inputStyle.copyWith(
                  hintText: "Enter description here....",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(kborderSize),
                  ),
                ),
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
              PriorityChoose(
                value: widget.taskModel?.priority ?? "Medium Priority",
                PriorityChooseActive: true,
              ),
              widget.editingPageMode
                  ? Column(
                      children: [
                        Container(height: 20),
                        SizedBox(
                          child: Row(
                            children: [
                              Container(width: 10),
                              const Text(
                                "Progress",
                              ),
                            ],
                          ),
                        ),
                        Container(height: 10),
                        ProgressChoose(
                          progressChooseActive: true,
                          value: widget.taskModel?.status ?? "Waiting",
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
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
                      child: BlocBuilder<AddingTaskCubit, AddingTaskState>(
                        builder: (context, state) {
                          return MaterialButton(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 110, vertical: 20),
                            color: mainColor,
                            onPressed: !context
                                    .watch<AddingTaskCubit>()
                                    .state
                                    .uploadingImage
                                ? () async {
                                    if (!widget.editingPageMode) {
                                      try {
                                        await context
                                            .read<AddingTaskCubit>()
                                            .addData(
                                              state.imagePath,
                                              state.date.toString(),
                                              state.priority,
                                              titleController.text,
                                              descriptionController.text,
                                            );
                                        context
                                            .read<AddingTaskCubit>()
                                            .resetAll();
                                        Navigator.of(context).pop();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content:
                                                Text("Added Task Successfully"),
                                          ),
                                        );
                                        await context
                                            .read<TaskCubit>()
                                            .fetchInitialTasks();
                                      } catch (e) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              e.toString(),
                                            ),
                                          ),
                                        );
                                      }
                                    } else {
                                      try {
                                        await context
                                            .read<AddingTaskCubit>()
                                            .editData(
                                              widget.taskModel!.id,
                                              widget.taskModel!.user,
                                              widget.taskModel!.priority,
                                              widget.taskModel!.status,
                                              titleController.text,
                                              descriptionController.text,
                                            );

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                "Edited Task Successfully"),
                                          ),
                                        );
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pop();
                                        context
                                            .read<TaskCubit>()
                                            .fetchInitialTasks();
                                      } catch (e) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              e.toString(),
                                            ),
                                          ),
                                        );
                                      }
                                    }
                                  }
                                : null,
                            child: SizedBox(
                              height: 30,
                              child: (state is AddingTaskLoading)
                                  ? const CircularProgressIndicator(
                                      color: Colors.white)
                                  : (!widget.editingPageMode)
                                      ? const Text(
                                          "Add Task",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                          ),
                                        )
                                      : const Text(
                                          "Edit Task",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                          ),
                                        ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
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
/*
 "image": "path.png",
        "title": "title",
        "desc": "desc",
        "priority": "low",
        "status": "waiting",
        "user": "6649fb2eef0bf93dd00711ba"
 */
