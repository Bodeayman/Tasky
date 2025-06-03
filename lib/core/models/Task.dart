import 'package:tasky/features/Presentation/HomePage/Widgets/taskBadge.dart';
import 'package:tasky/features/Presentation/HomePage/Widgets/taskPriorityIcon.dart';

class Task {
  TaskBadges progress;
  String dueDate;
  TaskProgress priority;
  String name;
  String desc;
  Task(this.progress, this.priority, this.name, this.dueDate, this.desc);
}
