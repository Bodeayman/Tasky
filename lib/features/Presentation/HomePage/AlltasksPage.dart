import 'package:flutter/material.dart';
import 'package:tasky/core/utils/style/colors.dart';
import 'package:tasky/features/Presentation/TaskDetails/TaskDetails.dart';

class Alltaskspage extends StatelessWidget {
  const Alltaskspage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return const TaskTile();
        },
      ),
    );
  }
}

class TaskImageTile extends StatelessWidget {
  const TaskImageTile({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      width: 64,
      child: Image.asset("assets/groceryOnline.png"),
    );
  }
}

class MoreDetailsIconButton extends StatelessWidget {
  const MoreDetailsIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.more_vert),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const TaskDetails(),
          ),
        );
      },
    );
  }
}

class TaskDetailsInTile extends StatelessWidget {
  const TaskDetailsInTile({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 64,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Grocery Shopping",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TaskBadge(),
            ],
          ),
          Text(
            "The application is designed ....",
            style: TextStyle(fontSize: 12),
          ),
          SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.flag, size: 16),
                  SizedBox(width: 4),
                  Text(
                    "Medium",
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
              SizedBox(width: 15),
              Text(
                "20/9/2025",
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TaskTile extends StatelessWidget {
  const TaskTile({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 96,
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TaskImageTile(),
          SizedBox(width: 20),
          Expanded(child: TaskDetailsInTile()),
          MoreDetailsIconButton(),
        ],
      ),
    );
  }
}

class TaskBadge extends StatelessWidget {
  const TaskBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Container(
        width: 55,
        height: 22,
        color: waitingTaskBadge,
        alignment: Alignment.center,
        child: Text(
          "Waiting",
          style: TextStyle(color: waitingTaskText, fontSize: 12),
        ),
      ),
    );
  }
}
