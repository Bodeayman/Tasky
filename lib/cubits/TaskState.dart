abstract class TaskState {}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final List<String> tasks;
  final bool hasReachedMax;

  TaskLoaded({required this.tasks, required this.hasReachedMax});
}

class TaskError extends TaskState {
  final String message;
  TaskError(this.message);
}
