import 'package:tasky/features/HomePage/Data/Models/Task.dart';

abstract class TaskState {}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final List<TaskModel> tasks;
  final bool reachedToEnd;
  final int page;
  TaskLoaded(
      {required this.tasks, required this.reachedToEnd, required this.page});
}

class TaskError extends TaskState {
  final String error;

  TaskError(this.error);
}
