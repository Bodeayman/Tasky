import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/features/HomePage/Presentation/Manager/TaskCubit.dart';
import 'package:tasky/features/HomePage/Presentation/Manager/TaskState.dart';
import 'package:tasky/features/HomePage/Presentation/Manager/factory_functions.dart';
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
    context.read<TaskCubit>().fetchInitialTasks(status: 'waiting');
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
    return RefreshIndicator(
      onRefresh: () => context.read<TaskCubit>().refreshTasks(),
      child: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          List tasks = [];
          bool showBottomLoader = false;

          if (state is TaskLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TaskError) {
            return Center(child: Text('Error: ${state.error}'));
          } else if (state is TaskLoaded) {
            tasks = state.tasks;
            showBottomLoader = false;
          } else if (state is TaskLoadingMore) {
            tasks = state.tasks;
            showBottomLoader = true;
          }

          if (tasks.isEmpty) {
            return const Center(child: Text("No waiting tasks found"));
          }

          return ListView.builder(
            controller: _scrollController,
            itemCount: tasks.length + (showBottomLoader ? 1 : 0),
            itemBuilder: (context, index) {
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
          );
        },
      ),
    );
  }
}
