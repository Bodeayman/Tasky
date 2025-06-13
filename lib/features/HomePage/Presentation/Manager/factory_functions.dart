import 'package:tasky/features/HomePage/Presentation/Views/Widgets/taskBadge.dart';
import 'package:tasky/features/HomePage/Presentation/Views/Widgets/taskPriorityIcon.dart';

TaskBadges mapPriority(String priority) {
  switch (priority.toLowerCase()) {
    case 'low':
      return TaskBadges.low;
    case 'medium':
      return TaskBadges.medium;
    case 'high':
      return TaskBadges.high;
    default:
      return TaskBadges.low;
  }
}

TaskProgress mapProgress(String status) {
  switch (status.toLowerCase()) {
    case 'waiting':
      return TaskProgress.waiting;
    case 'inprogress':
      return TaskProgress.inProgress;
    case 'finished':
      return TaskProgress.finished;
    default:
      return TaskProgress.waiting;
  }
}
