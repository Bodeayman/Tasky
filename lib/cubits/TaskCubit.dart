import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:tasky/features/Presentation/HomePage/Data/Models/Task.dart';
import 'package:tasky/core/utils/refresh_token.dart';
import 'package:tasky/core/utils/shared_prefs_service.dart';
import 'package:tasky/core/utils/url.dart';
import 'TaskState.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());

  Future<void> fetchTasks() async {
    emit(TaskLoading());

    try {
      final token = await getAccessToken();

      final response = await http.get(
        Uri.parse('$baseUrl/todos'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode != 200) {
        refreshAccessToken();
        throw Exception("Failed to load tasks: ${response.statusCode}");
      }

      final List<dynamic> data = jsonDecode(response.body);
      final List<Task> tasks = data.map((json) => Task.fromJson(json)).toList();

      emit(TaskLoaded(tasks: tasks));
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  Future<void> refreshTasks() async {
    await fetchTasks();
  }
}
