import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/features/HomePage/Data/Models/Task.dart';
import 'package:tasky/features/HomePage/Data/Repo/HomeRepo.dart';
import 'TaskState.dart';

class TaskCubit extends Cubit<TaskState> {
  final HomeRepo homeRepo;

  TaskCubit(this.homeRepo) : super(TaskInitial());

  Future<void> fetchInitialTasks() async {
    emit(TaskLoading());

    final result = await homeRepo.fetchTasks(page: 1);
    result.fold(
      (failure) => emit(TaskError(failure)),
      (tasks) => emit(
        TaskLoaded(
          tasks: tasks,
          page: 1,
          reachedToEnd: tasks.isEmpty,
        ),
      ),
    );
  }

  Future<void> fetchMoreTasks(BuildContext context) async {
    if (state is! TaskLoaded) return;

    final currentState = state as TaskLoaded;

    if (currentState.reachedToEnd ||
        currentState.tasks.length < MediaQuery.of(context).size.height / 100)
      return;

    // You can emit loading separately here if needed

    final nextPage = currentState.page + 1;

    final result = await homeRepo.fetchTasks(page: nextPage);
    result.fold(
      (failure) => emit(TaskError(failure)),
      (newTasks) {
        final allTasks = List<TaskModel>.from(currentState.tasks)
          ..addAll(newTasks);
        emit(TaskLoaded(
          tasks: allTasks,
          page: nextPage,
          reachedToEnd: newTasks.isEmpty,
        ));
      },
    );
  }

  Future<void> refreshTasks() async {
    await fetchInitialTasks();
  }
}
