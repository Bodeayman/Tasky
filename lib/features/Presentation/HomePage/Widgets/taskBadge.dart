import 'package:flutter/material.dart';
import 'package:tasky/core/utils/style/colors.dart';

class TaskBadgeTest extends StatelessWidget {
  const TaskBadgeTest(
      {super.key,
      required this.badgeText,
      required this.badgeColor,
      required this.textColor});
  final String badgeText;
  final Color badgeColor;
  final Color textColor;
  factory TaskBadgeTest.waiting() {
    return TaskBadgeTest(
      badgeText: "Waiting",
      badgeColor: waitingTaskBadge,
      textColor: waitingTaskText,
    );
  }

  factory TaskBadgeTest.completed() {
    return const TaskBadgeTest(
      badgeText: "Completed",
      badgeColor: Colors.green,
      textColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Container(
        width: 55,
        height: 22,
        color: badgeColor,
        alignment: Alignment.center,
        child: Text(
          badgeText,
          style: TextStyle(color: textColor, fontSize: 12),
        ),
      ),
    );
  }
}
