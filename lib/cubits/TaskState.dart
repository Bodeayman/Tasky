import 'package:tasky/core/models/Task.dart';

abstract class TaskState {}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final List<Task> tasks;

  TaskLoaded({required this.tasks});
}

class TaskError extends TaskState {
  final String error;

  TaskError(this.error);
}
