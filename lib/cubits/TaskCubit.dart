import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/cubits/TaskState.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());

  int page = 1;
  final int pageSize = 10;
  bool isFetching = false;

  void fetchTasks() async {
    if (isFetching) return;
    isFetching = true;

    try {
      if (state is TaskInitial) {
        emit(TaskLoading());
      }

      await Future.delayed(const Duration(milliseconds: 500));
      //List generate it will take the length of the list , and it will give it a specific item
      List<String> newTasks = List.generate(
        pageSize,
        (index) => 'Task ${(page - 1) * pageSize + index + 1}',
      );
      debugPrint(newTasks.first);

      List<String> allTasks = [];

      if (state is TaskLoaded) {
        allTasks = List.from((state as TaskLoaded).tasks)..addAll(newTasks);
      } else {
        allTasks = newTasks;
      }

      bool hasReachedMax = allTasks.length >= 50;

      emit(TaskLoaded(tasks: allTasks, hasReachedMax: hasReachedMax));

      page++;
    } catch (e) {
      emit(TaskError(e.toString()));
    } finally {
      isFetching = false;
    }
  }
}
