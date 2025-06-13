import 'package:tasky/features/HomePage/Data/Models/Task.dart';

abstract class TaskState {}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final List<TaskModel> tasks;
  final int page;
  final bool reachedToEndAll; // For All Tasks
  final bool reachedToEndWaiting; // For Waiting Tasks
  final bool reachedToEndInProgress; // For In Progress Tasks
  final bool reachedToEndFinished; // For Finished Tasks
  final bool hasMoreTasks;
  TaskLoaded({
    required this.tasks,
    required this.page,
    required this.reachedToEndAll,
    required this.reachedToEndWaiting,
    required this.reachedToEndInProgress,
    required this.reachedToEndFinished,
    required this.hasMoreTasks,
  });
}

class TaskError extends TaskState {
  final String error;
  TaskError(this.error);
}
