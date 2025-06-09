part of 'adding_task_cubit.dart';

class AddingTaskState {}

class AddingTaskInitial extends AddingTaskState {
  final String priority;
  final String date;
  final String progress; // ✅ Add this

  AddingTaskInitial(this.priority, this.date, this.progress);
}
