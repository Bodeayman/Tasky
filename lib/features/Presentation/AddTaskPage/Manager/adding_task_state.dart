part of 'adding_task_cubit.dart';

@immutable
sealed class AddingTaskState {}

final class AddingTaskInitial extends AddingTaskState {
  final String priority;
  final String date;
  AddingTaskInitial(this.priority, this.date);
}
