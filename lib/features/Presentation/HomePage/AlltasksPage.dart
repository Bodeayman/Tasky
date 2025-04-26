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
          itemBuilder: (context, index) {
            return const TaskTile();
          },
          itemCount: 10,
        ));
  }
}

class TaskImageTile extends StatelessWidget {
  const TaskImageTile({
    super.key,
  });

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
  const MoreDetailsIconButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: IconButton(
        icon: const Icon(Icons.more_vert),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const TaskDetails(),
            ),
          );
        },
      ),
    );
  }
}

class taskDetailsInTile extends StatelessWidget {
  const taskDetailsInTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 64,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Grocery Shopping",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TaskBadge()
            ],
          ),
          Text(
            "The application is designed ....",
            style: TextStyle(
              fontSize: 12,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.flag),
                  Text(
                    "Medium",
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                "20/9/2025",
                style: TextStyle(fontSize: 12),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class TaskTile extends StatelessWidget {
  const TaskTile({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 96,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const TaskImageTile(),
          Container(width: 20),
          const Expanded(child: taskDetailsInTile()),
          const MoreDetailsIconButton(),
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
      child: SizedBox(
        width: 55,
        height: 22,
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Container(
            color: waitingTaskBadge,
            child: Text("Waiting", style: TextStyle(color: waitingTaskText)),
          ),
        ),
      ),
    );
  }
}
