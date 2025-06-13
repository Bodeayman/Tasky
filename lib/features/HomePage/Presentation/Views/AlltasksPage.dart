import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/features/AddTaskPage/Manager/adding_task_cubit.dart';
import 'package:tasky/features/HomePage/Presentation/Manager/TaskCubit.dart';
import 'package:tasky/features/HomePage/Presentation/Manager/TaskState.dart';
import 'package:tasky/features/HomePage/Presentation/Manager/factory_functions.dart';
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
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<TaskCubit>().fetchInitialTasks();

    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<TaskCubit>().fetchMoreTasks(context, section: "all");
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => context.read<TaskCubit>().refreshTasks(),
      child: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          if (state is TaskLoading && state is! TaskLoaded) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TaskError) {
            return Center(
              child: Text('Error: ${state.error}'),
            );
          } else if (state is TaskLoaded) {
            if (state.tasks.isEmpty) {
              return const Center(
                child: Text("No tasks found"),
              );
            }

            return ListView.builder(
              controller: _scrollController,
              itemCount: state.reachedToEndAll
                  ? state.tasks.length
                  : state.tasks.length + 1,
              itemBuilder: (context, index) {
                if (index >= state.tasks.length) {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                final task = state.tasks[index];

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
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
