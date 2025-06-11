import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/features/HomePage/Presentation/Manager/TaskCubit.dart';
import 'package:tasky/features/HomePage/Presentation/Manager/TaskState.dart';
import 'package:tasky/features/HomePage/Presentation/Views/Widgets/taskBadge.dart';
import 'package:tasky/features/HomePage/Presentation/Views/Widgets/taskPriorityIcon.dart';
import 'package:tasky/features/HomePage/Presentation/Views/Widgets/taskTile.dart';

class Waitingtaskspage extends StatefulWidget {
  const Waitingtaskspage({super.key});

  @override
  State<Waitingtaskspage> createState() => _WaitingtaskspageState();
}

class _WaitingtaskspageState extends State<Waitingtaskspage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<TaskCubit>().fetchInitialTasks();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<TaskCubit>().fetchMoreTasks();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
          final waitingTasks = state.tasks
              .where((task) => task.status.toLowerCase() == 'waiting')
              .toList();

          if (waitingTasks.isEmpty) {
            return const Center(child: Text("No waiting tasks found"));
          }

          return RefreshIndicator(
            onRefresh: () => context.read<TaskCubit>().refreshTasks(),
            child: ListView.builder(
              controller: _scrollController,
              itemCount: state.reachedToEnd
                  ? waitingTasks.length
                  : waitingTasks.length + 1,
              itemBuilder: (context, index) {
                if (index >= waitingTasks.length) {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                final task = waitingTasks[index];
                return TaskTile(
                  id: task.id,
                  name: task.title,
                  desc: task.desc,
                  dueDate: task.createdAt.toLocal().toString().split(' ')[0],
                  priority: mapPriority(task.priority),
                  progress: mapProgress(task.status),
                  imagePath: task.image,
                  user: task.user,
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
