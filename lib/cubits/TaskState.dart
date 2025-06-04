import 'package:tasky/core/models/Task.dart';

abstract class TaskState {}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final List<Task> tasks;
  final bool hasReachedMax;

  TaskLoaded({required this.tasks, required this.hasReachedMax});

  TaskLoaded copyWith({
    List<Task>? tasks,
    bool? hasReachedMax,
  }) {
    return TaskLoaded(
      tasks: tasks ?? this.tasks,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}

class TaskError extends TaskState {
  final String error;

  TaskError(this.error);
}
