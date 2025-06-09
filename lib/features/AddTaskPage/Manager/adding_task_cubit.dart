import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
part 'adding_task_state.dart';

class AddingTaskCubit extends Cubit<AddingTaskState> {
  AddingTaskCubit()
      : super(AddingTaskInitial(
            'medium', DateTime.now().toUtc().toIso8601String(), 'low'));

  void setPriority(String newPriority) {
    final currentState = state as AddingTaskInitial;
    emit(
      AddingTaskInitial(
        newPriority,
        currentState.date,
        currentState.progress,
      ),
    );
  }

  void setDate(String newDate) {
    final currentState = state as AddingTaskInitial;
    emit(
      AddingTaskInitial(
        currentState.priority,
        newDate,
        currentState.progress,
      ),
    );
  }

  void setProgress(String newProgress) {
    final currentState = state as AddingTaskInitial;
    emit(
      AddingTaskInitial(
        currentState.priority,
        currentState.date,
        newProgress,
      ),
    );
  }

  void getData() {
    final currentState = state as AddingTaskInitial;
    debugPrint(currentState.date);
    debugPrint(currentState.priority);
    debugPrint(currentState.progress); // ✅ Optional: for debugging
  }
}
