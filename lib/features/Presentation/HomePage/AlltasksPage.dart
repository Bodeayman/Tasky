import 'package:flutter/material.dart';
import 'package:tasky/features/Presentation/TaskDetails/TaskDetails.dart';

class Alltaskspage extends StatelessWidget {
  const Alltaskspage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(children: [
        SizedBox(
          height: 96,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const TaskImageTile(),
              Container(width: 20),
              const taskDetailsInTile(),
              const MoreDetailsIconButton(),
            ],
          ),
        ),
      ]),
    );
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
          Text(
            "Grocery Shopping",
            style: TextStyle(fontSize: 16),
          ),
          Text(
            "The application is designed ....",
            style: TextStyle(
              fontSize: 12,
            ),
          ),
          Row(
            children: [
              Icon(Icons.flag),
              Text(
                "Medium",
                style: TextStyle(fontSize: 12),
              ),
            ],
          )
        ],
      ),
    );
  }
}
