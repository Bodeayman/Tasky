import 'package:flutter/material.dart';
import 'package:tasky/core/utils/style/colors.dart';

class TaskPriorityIcon extends StatelessWidget {
  const TaskPriorityIcon(
      {super.key, required this.priorityColor, required this.priorityText});
  final Color priorityColor;
  final String priorityText;

  factory TaskPriorityIcon.high() {
    return TaskPriorityIcon(
        priorityColor: waitingTaskText, priorityText: "High");
  }
  factory TaskPriorityIcon.med() {
    return TaskPriorityIcon(
        priorityColor: inProgressTaskText, priorityText: "Medium");
  }
  factory TaskPriorityIcon.low() {
    return TaskPriorityIcon(
        priorityColor: finishingTaskText, priorityText: "Low");
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.flag, size: 16, color: priorityColor),
        const SizedBox(width: 4),
        Text(
          priorityText,
          style: TextStyle(fontSize: 12, color: priorityColor),
        ),
      ],
    );
  }
}
