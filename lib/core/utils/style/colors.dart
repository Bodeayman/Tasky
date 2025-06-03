import 'dart:ui';
import 'package:flutter/material.dart';

Color mainColor = const Color(0xFF5F33E1);
Color lightPurple = const Color.fromARGB(255, 188, 181, 208);
Color priorityColor = const Color(0xffF0ECFF);
Color inputFieldBorderColor = const Color(0xffBABABA);
Color unselectedColor = const Color(0xffF0ECFF);

Color waitingTaskBadge = const Color(0xFFFFE4F2);
Color waitingTaskText = const Color(0xffFF7D53);

Color finishingTaskBadge = const Color(0xffE3F2FF);
Color finishingTaskText = const Color(0xff0087FF);

Color inProgressTaskBadge = const Color(0xffF0ECFF);
Color inProgressTaskText = const Color(0xff5F33E1);

class TaskBadge {
  Color taskBackground;
  Color taskColor;
  TaskBadge(this.taskBackground, this.taskColor);
}
