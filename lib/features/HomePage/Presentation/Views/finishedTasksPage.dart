import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/features/HomePage/Data/Models/Task.dart';
import 'package:tasky/features/HomePage/Presentation/Manager/TaskCubit.dart';
import 'package:tasky/features/HomePage/Presentation/Manager/TaskState.dart';
import 'package:tasky/features/HomePage/Presentation/Views/Widgets/taskTile.dart';
import 'package:tasky/features/HomePage/Presentation/Manager/factory_functions.dart';

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
    context.read<TaskCubit>().fetchInitialTasks(status: "finished");
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubit, TaskState>(
      builder: (context, state) {
        List<TaskModel> tasks = [];
        bool showBottomLoader = false;

        if (state is TaskLoaded) {
          tasks = state.tasks;
        } else if (state is TaskLoadingMore) {
          tasks = state.tasks;
          showBottomLoader = true;
        }

        return RefreshIndicator(
          onRefresh: () => context.read<TaskCubit>().refreshTasks(),
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: _scrollController,
            itemCount:
                (tasks.isEmpty ? 1 : tasks.length) + (showBottomLoader ? 1 : 0),
            itemBuilder: (context, index) {
              if (tasks.isEmpty) {
                if (state is TaskLoading) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height -
                        kToolbarHeight -
                        100,
                    child: const Center(child: CircularProgressIndicator()),
                  );
                } else if (state is TaskError) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height -
                        kToolbarHeight -
                        100,
                    child: Center(child: Text('Error: ${state.error}')),
                  );
                } else {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height -
                        kToolbarHeight -
                        100,
                    child: const Center(child: Text("No finished tasks found")),
                  );
                }
              }

              if (index >= tasks.length) {
                return const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              final task = tasks[index];
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
      },
    );
  }
}
