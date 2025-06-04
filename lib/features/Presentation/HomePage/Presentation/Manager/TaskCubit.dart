import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:tasky/features/Presentation/HomePage/Data/Models/Task.dart';
import 'package:tasky/core/utils/refresh_token.dart';
import 'package:tasky/core/utils/shared_prefs_service.dart';
import 'package:tasky/core/utils/url.dart';
import 'package:tasky/features/Presentation/HomePage/Data/Repo/HomeRepo.dart';
import 'TaskState.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit(this.homeRepo) : super(TaskInitial());
  final HomeRepo homeRepo;
  Future<void> fetchTasks() async {
    emit(TaskLoading());
    var result = await homeRepo.fetchTasks();
    result.fold(
      (failure) => emit(
        TaskError(
          failure,
        ),
      ),
      (tasks) => emit(
        TaskLoaded(
          tasks: tasks,
        ),
      ),
    );
  }

  Future<void> refreshTasks() async {
    await fetchTasks();
  }
}
