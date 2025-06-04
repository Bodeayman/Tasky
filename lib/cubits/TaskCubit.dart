import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:tasky/core/models/Task.dart';
import 'package:tasky/core/utils/refresh_token.dart';
import 'package:tasky/core/utils/shared_prefs_service.dart';
import 'package:tasky/core/utils/url.dart';
import 'package:tasky/cubits/TaskState.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());

  int page = 1;
  final int pageSize = 10;
  bool isFetching = false;

  void fetchTasks() async {
    if (isFetching) return;
    isFetching = true;

    try {
      if (state is TaskInitial) {
        emit(TaskLoading());
      }

      final token = await getAccessToken();

      final response = await http.get(
        Uri.parse('$baseUrl/todos?page=$page'),
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

      final List<Task> newTasks =
          data.map((json) => Task.fromJson(json)).toList();

      List<Task> allTasks = [];

      if (state is TaskLoaded) {
        allTasks = List.from((state as TaskLoaded).tasks)..addAll(newTasks);
      } else {
        allTasks = newTasks;
      }

      // Determine if this is the last page
      const int pageSize = 10; // Backend's fixed page size (assumption)
      bool hasReachedMax = newTasks.length < pageSize;

      emit(TaskLoaded(tasks: allTasks, hasReachedMax: hasReachedMax));

      page++;
    } catch (e) {
      emit(TaskError(e.toString()));
    } finally {
      isFetching = false;
    }
  }
}
