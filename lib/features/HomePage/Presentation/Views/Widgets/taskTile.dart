import 'package:flutter/material.dart';
import 'package:tasky/core/utils/url.dart';
import 'package:tasky/features/HomePage/Data/Models/Task.dart';
import 'package:tasky/features/HomePage/Presentation/Views/Widgets/taskBadge.dart';
import 'package:tasky/features/HomePage/Presentation/Views/Widgets/taskPriorityIcon.dart';
import 'package:tasky/features/TaskDetails/Presentation/Views/TaskDetails.dart';

class TaskTile extends StatelessWidget {
  const TaskTile(
      {super.key,
      required this.id,
      required this.name,
      required this.desc,
      required this.dueDate,
      required this.priority,
      required this.progress,
      required this.imagePath,
      required this.user});
  final String id;
  final String name;
  final String desc;
  final String dueDate;
  final TaskBadges priority;
  final TaskProgress progress;
  final String imagePath;
  final String user;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 96,
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 64,
            width: 64,
            child: Image.network(
              "$baseUrl/images/$imagePath",
              errorBuilder: (context, error, stackTrace) {
                return Container(
                    color: Colors.red,
                    child: const Center(
                      child: Text("Error"),
                    ));
              },
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: TaskDetailsInTile(
              name: name,
              desc: desc,
              dueDate: dueDate,
              priority: priority,
              progress: progress,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TaskDetails(
                    taskModel: TaskModel(
                        image: imagePath,
                        desc: desc,
                        priority: priority.toString(),
                        status: progress.toString(),
                        title: name,
                        createdAt: DateTime.tryParse(dueDate) ?? DateTime.now(),
                        updatedAt: DateTime.tryParse(dueDate) ?? DateTime.now(),
                        user: user,
                        id: id),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class TaskDetailsInTile extends StatelessWidget {
  const TaskDetailsInTile({
    super.key,
    required this.name,
    required this.desc,
    required this.dueDate,
    required this.priority,
    required this.progress,
  });

  final String name;
  final String desc;
  final String dueDate;
  final TaskBadges priority;
  final TaskProgress progress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              switch (progress) {
                TaskProgress.waiting => TaskBadgeTest.waiting(),
                TaskProgress.inProgress => TaskBadgeTest.inprogress(),
                TaskProgress.finished => TaskBadgeTest.finished(),
              },
            ],
          ),
          Text(
            desc,
            style: const TextStyle(
              fontSize: 12,
              overflow: TextOverflow.clip,
            ),
            maxLines: 1,
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              switch (priority) {
                TaskBadges.low => TaskPriorityIcon.low(),
                TaskBadges.medium => TaskPriorityIcon.med(),
                TaskBadges.high => TaskPriorityIcon.high(),
              },
              const SizedBox(width: 15),
              Text(
                dueDate,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
