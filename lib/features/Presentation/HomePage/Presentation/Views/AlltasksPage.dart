import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/features/Presentation/HomePage/Data/Models/Task.dart';
import 'package:tasky/core/utils/style/colors.dart';
import 'package:tasky/core/utils/url.dart';
import 'package:tasky/cubits/TaskCubit.dart';
import 'package:tasky/cubits/TaskState.dart';
import 'package:tasky/features/Presentation/HomePage/Presentation/Views/Widgets/taskBadge.dart';
import 'package:tasky/features/Presentation/HomePage/Presentation/Views/Widgets/taskPriorityIcon.dart';
import 'package:tasky/features/Presentation/TaskDetails/Presentation/Views/TaskDetails.dart';

class Alltaskspage extends StatefulWidget {
  const Alltaskspage({super.key});

  @override
  State<Alltaskspage> createState() => _AlltaskspageState();
}

class _AlltaskspageState extends State<Alltaskspage> {
  @override
  void initState() {
    super.initState();
    context.read<TaskCubit>().fetchTasks();
  }

  TaskBadges mapPriority(String priority) {
    switch (priority.toLowerCase()) {
      case 'low':
        return TaskBadges.low;
      case 'medium':
        return TaskBadges.medium;
      case 'high':
        return TaskBadges.high;
      default:
        return TaskBadges.low;
    }
  }

  TaskProgress mapProgress(String status) {
    switch (status.toLowerCase()) {
      case 'waiting':
        return TaskProgress.waiting;
      case 'in_progress':
        return TaskProgress.inProgress;
      case 'finished':
        return TaskProgress.finished;
      default:
        return TaskProgress.waiting;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubit, TaskState>(
      builder: (context, state) {
        if (state is TaskLoading && state is! TaskLoaded) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is TaskError) {
          return Center(child: Text('Error: ${state.error}'));
        } else if (state is TaskLoaded) {
          if (state.tasks.isEmpty) {
            return const Center(child: Text("No tasks found"));
          }

          return RefreshIndicator(
            onRefresh: () => context.read<TaskCubit>().refreshTasks(),
            child: ListView.builder(
              itemCount: state.tasks.length,
              itemBuilder: (context, index) {
                final task = state.tasks[index];

                return TaskTile(
                  id: task.id,
                  name: task.title,
                  desc: task.desc,
                  dueDate: task.createdAt.toLocal().toString().split(' ')[0],
                  priority: mapPriority(task.priority),
                  progress: mapProgress(task.status),
                  imagePath: task.image,
                );
              },
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

class TaskTile extends StatelessWidget {
  const TaskTile(
      {super.key,
      required this.id,
      required this.name,
      required this.desc,
      required this.dueDate,
      required this.priority,
      required this.progress,
      required this.imagePath});
  final String id;
  final String name;
  final String desc;
  final String dueDate;
  final TaskBadges priority;
  final TaskProgress progress;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 96,
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 64,
            width: 64,
            // child: Image.network("$baseUrl/images/$image"),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: TaskDetailsInTile(
              name: name,
              desc: desc,
              dueDate: dueDate,
              priority: priority,
              progress: progress,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TaskDetails(
                    taskModel: Task(
                        image: imagePath,
                        desc: desc,
                        priority: "Low",
                        status: "Waiting",
                        title: name,
                        createdAt: DateTime.now(),
                        updatedAt: DateTime.now(),
                        user: "",
                        id: id),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class TaskDetailsInTile extends StatelessWidget {
  const TaskDetailsInTile({
    super.key,
    required this.name,
    required this.desc,
    required this.dueDate,
    required this.priority,
    required this.progress,
  });

  final String name;
  final String desc;
  final String dueDate;
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
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              switch (progress) {
                TaskProgress.waiting => TaskBadgeTest.waiting(),
                TaskProgress.inProgress => TaskBadgeTest.inprogress(),
                TaskProgress.finished => TaskBadgeTest.finished(),
              },
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
              switch (priority) {
                TaskBadges.low => TaskPriorityIcon.low(),
                TaskBadges.medium => TaskPriorityIcon.med(),
                TaskBadges.high => TaskPriorityIcon.high(),
              },
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
