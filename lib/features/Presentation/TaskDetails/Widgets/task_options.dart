import 'package:flutter/material.dart';

class TaskOptionsActionButton extends StatelessWidget {
  const TaskOptionsActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.more_vert),
        onPressed: () => showMenu(
              context: context,
              items: [
                const PopupMenuItem(
                    child: Text(
                  "Edit",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
                const PopupMenuItem(
                    child: Text("Delete",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.orange)))
              ],
              position: RelativeRect.fromLTRB(
                  MediaQuery.of(context).size.width, 50, 0, 0),
            ));
  }
}
