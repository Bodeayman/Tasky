import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/features/HomePage/Presentation/Manager/TaskCubit.dart';
import 'package:tasky/features/HomePage/Presentation/Manager/TaskState.dart';
import 'package:tasky/features/HomePage/Presentation/Manager/factory_functions.dart';
import 'package:tasky/features/HomePage/Presentation/Views/Widgets/taskBadge.dart';
import 'package:tasky/features/HomePage/Presentation/Views/Widgets/taskPriorityIcon.dart';
import 'package:tasky/features/HomePage/Presentation/Views/Widgets/taskTile.dart';

class Finishedtaskspage extends StatefulWidget {
  const Finishedtaskspage({super.key});

  @override
  State<Finishedtaskspage> createState() => _FinishedtaskspageState();
}

class _FinishedtaskspageState extends State<Finishedtaskspage> {
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
      context.read<TaskCubit>().fetchMoreTasks(context, section: 'finished');
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
          final finishedTasks = state.tasks
              .where((task) => task.status.toLowerCase() == 'finished')
              .toList();

          if (finishedTasks.isEmpty) {
            // If no finished tasks but more tasks are available, trigger fetch
            if (state.hasMoreTasks && !state.reachedToEndFinished) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                context
                    .read<TaskCubit>()
                    .fetchMoreTasks(context, section: 'finished');
              });
              return const Center(child: CircularProgressIndicator());
            }
            return const Center(child: Text("No finished tasks found"));
          }

          return RefreshIndicator(
            onRefresh: () => context.read<TaskCubit>().refreshTasks(),
            child: ListView.builder(
              controller: _scrollController,
              itemCount: state.reachedToEndFinished
                  ? finishedTasks.length
                  : finishedTasks.length + 1,
              itemBuilder: (context, index) {
                if (index >= finishedTasks.length) {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                final task = finishedTasks[index];
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
