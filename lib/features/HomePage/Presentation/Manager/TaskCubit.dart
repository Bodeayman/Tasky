import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/features/HomePage/Data/Models/Task.dart';
import 'package:tasky/features/HomePage/Data/Repo/HomeRepo.dart';
import 'TaskState.dart';

class TaskCubit extends Cubit<TaskState> {
  final HomeRepo homeRepo;
  static const int pageSize = 20;

  TaskCubit(this.homeRepo) : super(TaskInitial());

  Future<void> fetchInitialTasks() async {
    emit(TaskLoading());

    final result = await homeRepo.fetchTasks(page: 1);
    result.fold(
      (failure) => emit(TaskError(failure)),
      (tasks) {
        final waitingCount = tasks
            .where((task) => task.status.toLowerCase() == 'waiting')
            .length;
        final inProgressCount = tasks
            .where((task) => task.status.toLowerCase() == 'inprogress')
            .length;
        final finishedCount = tasks
            .where((task) => task.status.toLowerCase() == 'finished')
            .length;

        emit(TaskLoaded(
          tasks: tasks,
          page: 1,
          reachedToEndAll: tasks.length < pageSize,
          reachedToEndWaiting: waitingCount == 0 && tasks.length < pageSize,
          reachedToEndInProgress:
              inProgressCount == 0 && tasks.length < pageSize,
          reachedToEndFinished: finishedCount == 0 && tasks.length < pageSize,
          hasMoreTasks:
              tasks.length == pageSize, // More pages to fetch if full page size
        ));

        // If no tasks for a section but more tasks are available, fetch next page
        if (tasks.length == pageSize &&
            (waitingCount == 0 || inProgressCount == 0 || finishedCount == 0)) {
          fetchMoreTasks(null, section: 'initial');
        }
      },
    );
  }

  Future<void> fetchMoreTasks(BuildContext? context,
      {required String section}) async {
    if (state is! TaskLoaded) return;

    final currentState = state as TaskLoaded;
    if (!currentState.hasMoreTasks) return;

    // Skip fetching if the section has already reached its end
    bool reachedToEnd = false;
    switch (section) {
      case 'all':
        reachedToEnd = currentState.reachedToEndAll;
        break;
      case 'waiting':
        reachedToEnd = currentState.reachedToEndWaiting;
        break;
      case 'inprogress':
        reachedToEnd = currentState.reachedToEndInProgress;
        break;
      case 'finished':
        reachedToEnd = currentState.reachedToEndFinished;
        break;
      case 'initial': // For initial fetch continuation
        reachedToEnd = currentState.reachedToEndAll;
        break;
    }

    if (reachedToEnd) return;

    final nextPage = currentState.page + 1;
    final result = await homeRepo.fetchTasks(page: nextPage);
    result.fold(
      (failure) => emit(TaskError(failure)),
      (newTasks) {
        final allTasks = List<TaskModel>.from(currentState.tasks)
          ..addAll(newTasks);

        final waitingCount = newTasks
            .where((task) => task.status.toLowerCase() == 'waiting')
            .length;
        final inProgressCount = newTasks
            .where((task) => task.status.toLowerCase() == 'inprogress')
            .length;
        final finishedCount = newTasks
            .where((task) => task.status.toLowerCase() == 'finished')
            .length;

        emit(TaskLoaded(
          tasks: allTasks,
          page: nextPage,
          reachedToEndAll: newTasks.length < pageSize,
          reachedToEndWaiting:
              currentState.reachedToEndWaiting && waitingCount == 0,
          reachedToEndInProgress:
              currentState.reachedToEndInProgress && inProgressCount == 0,
          reachedToEndFinished:
              currentState.reachedToEndFinished && finishedCount == 0,
          hasMoreTasks: newTasks.length == pageSize,
        ));

        // Continue fetching if no tasks for the section but more tasks are available
        if (section != 'initial' &&
            newTasks.length == pageSize &&
            ((section == 'waiting' && waitingCount == 0) ||
                (section == 'inprogress' && inProgressCount == 0) ||
                (section == 'finished' && finishedCount == 0))) {
          fetchMoreTasks(context, section: section);
        }
      },
    );
  }

  Future<void> refreshTasks() async {
    await fetchInitialTasks();
  }
}
