part of 'adding_task_cubit.dart';

class AddingTaskState {
  final String priority;
  final String date;
  final String progress; // ✅ Add this
  final String imagePath;
  AddingTaskState(this.priority, this.date, this.progress, this.imagePath);
}

class AddingTaskLoading extends AddingTaskState {
  AddingTaskLoading(
      super.priority, super.date, super.progress, super.imagePath);
}
