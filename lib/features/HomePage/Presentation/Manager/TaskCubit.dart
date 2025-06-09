import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/features/HomePage/Data/Repo/HomeRepo.dart';
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
