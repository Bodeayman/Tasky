import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' as context;
import 'package:intl/intl.dart';
import 'package:tasky/core/utils/refresh_token.dart';
import 'package:tasky/core/utils/shared_prefs_service.dart';
import 'package:tasky/core/utils/url.dart';
import 'package:tasky/features/HomePage/Presentation/Manager/TaskCubit.dart';
part 'adding_task_state.dart';

class AddingTaskCubit extends Cubit<AddingTaskState> {
  AddingTaskCubit()
      : super(
          AddingTaskState(
              'medium',
              DateFormat('yyyy-MM-dd').format(DateTime.now()),
              'waiting',
              'path.png',
              false),
        );

  void setPriority(String newPriority) {
    final currentState = state;
    emit(
      AddingTaskState(newPriority, currentState.date, currentState.progress,
          currentState.imagePath, false),
    );
  }

  void setDate(String newDate) {
    final currentState = state;
    emit(
      AddingTaskState(currentState.priority, newDate, currentState.progress,
          currentState.imagePath, false),
    );
  }

  void setProgress(String newProgress) {
    final currentState = state;
    emit(
      AddingTaskState(currentState.priority, currentState.date, newProgress,
          currentState.imagePath, false),
    );
  }

  void setImagePath(String? newImagePath) {
    final currentState = state;
    debugPrint(newImagePath);

    emit(
      AddingTaskState(currentState.priority, currentState.date,
          currentState.progress, newImagePath ?? "path.png", false),
    );
  }

  void resetAll() {
    emit(
      AddingTaskState('medium', DateFormat('yyyy-MM-dd').format(DateTime.now()),
          'waiting', 'path.png', false),
    );
  }

  Future<void> editData(
    String taskId,
    String user,
    String priority,
    String progress,
    String title,
    String desc,
  ) async {
    emit(
      AddingTaskLoading(
          state.priority, state.date, state.progress, state.imagePath, false),
    );

    final token = await getAccessToken();
    debugPrint("Coming from inside the cubit , ${state.imagePath}");
    final response = await http.put(
      Uri.parse('$baseUrl/todos/$taskId'),
      body: {
        "image": state.imagePath,
        "status": state.progress,
        "priority": state.priority,
        "title": title,
        "desc": desc,
        "user": user,
      },
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    emit(
      AddingTaskState(
          state.priority, state.date, state.progress, state.imagePath, false),
    );
    if (response.statusCode == 401) {
      await refreshAccessToken();
      throw Exception(
        "Failed to Add another Task, Please Try again",
      );
    }
  }

  void addingImage() {
    emit(AddingTaskState(
        state.priority, state.date, state.progress, state.imagePath, true));
  }

  void finishedUploadingImages() {
    emit(AddingTaskState(
        state.priority, state.date, state.progress, state.imagePath, false));
  }

  Future<void> addData(String imagePath, String date, String priority,
      String title, String desc) async {
    emit(
      AddingTaskLoading(
          state.priority, state.date, state.progress, state.imagePath, false),
    );
    final token = await getAccessToken();
    final response = await http.post(
      Uri.parse('$baseUrl/todos'),
      body: {
        "image": state.imagePath,
        "dueDate": state.date.toString(),
        "priority": state.priority,
        "title": title,
        "desc": desc,
      },
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    emit(
      AddingTaskState(
          state.priority, state.date, state.progress, state.imagePath, false),
    );
    debugPrint(response.body);

    if (response.statusCode == 401) {
      await refreshAccessToken();
      throw Exception(
        "Failed to Add another Task, Please Try again",
      );
    }
  }

  void getData() {
    final currentState = state;
    debugPrint(currentState.date);
    debugPrint(currentState.priority);
    debugPrint(currentState.progress); // ✅ Optional: for debugging
    debugPrint(currentState.imagePath); // ✅ Optional: for debugging
  }
}
