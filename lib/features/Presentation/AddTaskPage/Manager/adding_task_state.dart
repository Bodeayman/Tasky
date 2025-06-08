part of 'adding_task_cubit.dart';

abstract class AddingTaskState {}

class AddingTaskInitial extends AddingTaskState {
  final String priority;
  final String date;
  final String progress;

  AddingTaskInitial(this.priority, this.date, this.progress);

  // ✅ Add copyWith
  AddingTaskInitial copyWith({
    String? priority,
    String? date,
    String? progress,
  }) {
    return AddingTaskInitial(
      priority ?? this.priority,
      date ?? this.date,
      progress ?? this.progress,
    );
  }
}
