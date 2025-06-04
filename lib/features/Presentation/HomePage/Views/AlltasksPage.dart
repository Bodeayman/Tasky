import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/utils/style/colors.dart';
import 'package:tasky/core/utils/url.dart';
import 'package:tasky/cubits/TaskCubit.dart';
import 'package:tasky/cubits/TaskState.dart';
import 'package:tasky/features/Presentation/HomePage/Views/Widgets/taskBadge.dart';
import 'package:tasky/features/Presentation/HomePage/Views/Widgets/taskPriorityIcon.dart';
import 'package:tasky/features/Presentation/TaskDetails/Views/TaskDetails.dart';

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
    context.read<TaskCubit>().fetchTasks();

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
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // Helper function to map priority string to enum
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

  // Helper function to map status string to enum
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

          return ListView.builder(
            controller: _scrollController,
            itemCount: state.hasReachedMax
                ? state.tasks.length
                : state.tasks.length + 1,
            itemBuilder: (context, index) {
              if (index < state.tasks.length) {
                final task = state.tasks[index]; // task is TaskModel

                return TaskTile(
                    name: task.title,
                    desc: task.desc,
                    dueDate: task.createdAt.toLocal().toString().split(' ')[0],
                    priority: mapPriority(task.priority),
                    progress: mapProgress(task.status),
                    imagePath: task.image);
              } else {
                return const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              return null;
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

// -- Task Tile Related Widgets --

class TaskTile extends StatelessWidget {
  const TaskTile(
      {super.key,
      required this.name,
      required this.desc,
      required this.dueDate,
      required this.priority,
      required this.progress,
      required this.imagePath});

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
          TaskImageTile(
            image: imagePath,
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
          const MoreDetailsIconButton(),
        ],
      ),
    );
  }
}

class TaskImageTile extends StatelessWidget {
  const TaskImageTile({super.key, required this.image});
  final String image;
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 64,
      width: 64,
      // child: Image.network("$baseUrl/images/$image"),
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
