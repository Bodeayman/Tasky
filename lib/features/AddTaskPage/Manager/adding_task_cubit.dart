import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
part 'adding_task_state.dart';

class AddingTaskCubit extends Cubit<AddingTaskState> {
  AddingTaskCubit()
      : super(
          AddingTaskInitial(
            'medium',
            DateFormat('yyyy-MM-dd').format(DateTime.now()),
            'low',
            'path.png',
          ),
        );

  void setPriority(String newPriority) {
    final currentState = state as AddingTaskInitial;
    emit(
      AddingTaskInitial(newPriority, currentState.date, currentState.progress,
          currentState.imagePath),
    );
  }

  void setDate(String newDate) {
    final currentState = state as AddingTaskInitial;
    emit(
      AddingTaskInitial(currentState.priority, newDate, currentState.progress,
          currentState.imagePath),
    );
  }

  void setProgress(String newProgress) {
    final currentState = state as AddingTaskInitial;
    emit(
      AddingTaskInitial(currentState.priority, currentState.date, newProgress,
          currentState.imagePath),
    );
  }

  void setImagePath(String newImagePath) {
    final currentState = state as AddingTaskInitial;
    debugPrint(newImagePath);

    emit(
      AddingTaskInitial(currentState.priority, currentState.date,
          currentState.progress, newImagePath),
    );
  }

  void resetAll() {
    emit(
      AddingTaskInitial(
        'medium',
        DateFormat('yyyy-MM-dd').format(DateTime.now()),
        'low',
        'path.png',
      ),
    );
  }

  void getData() {
    final currentState = state as AddingTaskInitial;
    debugPrint(currentState.date);
    debugPrint(currentState.priority);
    debugPrint(currentState.progress); // ✅ Optional: for debugging
    debugPrint(currentState.imagePath); // ✅ Optional: for debugging
  }
}
