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

      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      // Simulate fetched data
      List<String> newTasks = List.generate(
          pageSize, (index) => 'Task ${(page - 1) * pageSize + index + 1}');

      List<String> allTasks = [];

      if (state is TaskLoaded) {
        allTasks = List.from((state as TaskLoaded).tasks)..addAll(newTasks);
      } else {
        allTasks = newTasks;
      }

      // Stop at 50 tasks for example
      bool hasReachedMax = allTasks.length >= 50;

      emit(TaskLoaded(tasks: allTasks, hasReachedMax: hasReachedMax));

      page++;
    } catch (e) {
      emit(TaskError(e.toString()));
    } finally {
      isFetching = false;
    }
  }
}
