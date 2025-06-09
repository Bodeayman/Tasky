import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/features/HomePage/Presentation/Manager/TaskCubit.dart';
import 'package:tasky/features/HomePage/Presentation/Manager/TaskState.dart';
import 'package:tasky/features/HomePage/Presentation/Views/Widgets/taskBadge.dart';
import 'package:tasky/features/HomePage/Presentation/Views/Widgets/taskPriorityIcon.dart';
import 'package:tasky/features/HomePage/Presentation/Views/Widgets/taskTile.dart';
import 'package:tasky/features/TaskDetails/Presentation/Views/TaskDetails.dart';

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
      case 'inprogress':
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
                    user: task.user);
              },
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
