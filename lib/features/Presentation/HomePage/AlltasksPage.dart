import 'package:flutter/material.dart';
import 'package:tasky/core/utils/style/colors.dart';
import 'package:tasky/cubits/TaskCubit.dart';
import 'package:tasky/cubits/TaskState.dart';
import 'package:tasky/features/Presentation/HomePage/Widgets/taskBadge.dart';
import 'package:tasky/features/Presentation/HomePage/Widgets/taskPriorityIcon.dart';
import 'package:tasky/features/Presentation/TaskDetails/TaskDetails.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/utils/style/colors.dart';
import 'package:tasky/features/Presentation/TaskDetails/TaskDetails.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/utils/style/colors.dart';
import 'package:tasky/features/Presentation/TaskDetails/TaskDetails.dart';

// Import your cubit and states here

class Alltaskspage extends StatefulWidget {
  const Alltaskspage({super.key});

  @override
  State<Alltaskspage> createState() => _AlltaskspageState();
}

class _AlltaskspageState extends State<Alltaskspage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // Load initial tasks
    context.read<TaskCubit>().fetchTasks();

    // Add listener for pagination
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        final cubit = context.read<TaskCubit>();
        final state = cubit.state;
        if (state is TaskLoaded && !state.hasReachedMax) {
          cubit.fetchTasks();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubit, TaskState>(
      builder: (context, state) {
        if (state is TaskLoading && state is! TaskLoaded) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is TaskError) {
          return Center(child: Text('Error: ${state.message}'));
        } else if (state is TaskLoaded) {
          if (state.tasks.isEmpty) {
            return const Center(child: Text("No tasks found"));
          }

          return ListView.builder(
            controller: _scrollController,
            itemCount: state.hasReachedMax
                ? state.tasks.length
                : state.tasks.length + 1, // +1 for loading indicator
            itemBuilder: (context, index) {
              if (index < state.tasks.length) {
                final task = state.tasks[index];
                return const TaskTile(
                  desc:
                      "This is the best grocercy shop that you will ever test",
                  dueDate: "2025-06-09",
                  name: "Grocery Shopping",
                  priority: TaskBadges.low,
                  progress: TaskProgress.inProgress,
                );
              } else {
                // Loading indicator at bottom while fetching more
                return const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

// Minimal Task model class example

// TaskTile that accepts data
class MoreDetailsIconButton extends StatelessWidget {
  const MoreDetailsIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.more_vert),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const TaskDetails(),
          ),
        );
      },
    );
  }
}

class TaskImageTile extends StatelessWidget {
  const TaskImageTile({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      width: 64,
      child: Image.asset("assets/groceryOnline.png"),
    );
  }
}

class TaskDetailsInTile extends StatelessWidget {
  const TaskDetailsInTile(
      {super.key,
      required this.name,
      required this.desc,
      required this.dueDate,
      required this.priority,
      required this.progress});
  final String name;
  final String desc;
  final String dueDate; //This is for the test
  final TaskBadges priority;
  final TaskProgress progress;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              (progress == TaskProgress.waiting)
                  ? TaskBadgeTest.waiting()
                  : (progress == TaskProgress.inProgress)
                      ? TaskBadgeTest.inprogress()
                      : TaskBadgeTest.finished(),
            ],
          ),
          Text(
            desc,
            style: const TextStyle(
              fontSize: 12,
              overflow: TextOverflow.clip,
            ),
            maxLines: 1,
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              (priority == TaskBadges.low)
                  ? TaskPriorityIcon.low()
                  : (priority == TaskBadges.medium)
                      ? TaskPriorityIcon.med()
                      : TaskPriorityIcon.high(),
              const SizedBox(width: 15),
              Text(
                dueDate,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TaskTile extends StatelessWidget {
  const TaskTile(
      {super.key,
      required this.name,
      required this.desc,
      required this.dueDate,
      required this.priority,
      required this.progress});
  final String name;
  final String desc;
  final String dueDate; //This is for the test
  final TaskBadges priority;
  final TaskProgress progress;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 96,
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const TaskImageTile(),
          const SizedBox(width: 20),
          Expanded(
              child: TaskDetailsInTile(
            desc: desc,
            dueDate: dueDate,
            name: name,
            priority: priority,
            progress: progress,
          )),
          const MoreDetailsIconButton(),
        ],
      ),
    );
  }
}
