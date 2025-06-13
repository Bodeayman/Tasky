import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/features/HomePage/Data/Models/Task.dart';
import 'package:tasky/features/HomePage/Data/Repo/HomeRepo.dart';
import 'TaskState.dart';

class TaskCubit extends Cubit<TaskState> {
  final HomeRepo homeRepo;

  int _currentPage = 1;
  bool _reachedToEnd = false;
  bool _isLoadingMore = false;
  String? _currentStatus;

  TaskCubit(this.homeRepo) : super(TaskInitial());

  Future<void> fetchInitialTasks({String? status}) async {
    emit(TaskLoading());
    _currentPage = 1;
    _reachedToEnd = false;
    _currentStatus = status;

    final result =
        await homeRepo.fetchTasks(page: _currentPage, status: _currentStatus);

    result.fold(
      (failure) => emit(TaskError(failure)),
      (tasks) {
        _reachedToEnd = tasks.isEmpty;
        emit(TaskLoaded(
            tasks: tasks, reachedToEnd: _reachedToEnd, page: _currentPage));
      },
    );
  }

  Future<void> fetchMoreTasks() async {
    if (_isLoadingMore || _reachedToEnd) return;
    if (state is! TaskLoaded) return;

    _isLoadingMore = true;
    final currentState = state as TaskLoaded;
    emit(TaskLoadingMore(currentState.tasks));

    final nextPage = _currentPage + 1;
    final result =
        await homeRepo.fetchTasks(page: nextPage, status: _currentStatus);

    result.fold(
      (failure) {
        _isLoadingMore = false;
        emit(TaskError(failure));
      },
      (newTasks) {
        _currentPage = nextPage;
        _reachedToEnd = newTasks.isEmpty;
        final allTasks = [...currentState.tasks, ...newTasks];
        _isLoadingMore = false;
        emit(TaskLoaded(
            tasks: allTasks, reachedToEnd: _reachedToEnd, page: _currentPage));
      },
    );
  }

  Future<void> refreshTasks() async {
    await fetchInitialTasks(status: _currentStatus);
  }
}
