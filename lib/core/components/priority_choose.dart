import 'package:flutter/material.dart';
import 'package:tasky/core/utils/constants.dart';
import 'package:tasky/core/utils/style/colors.dart';

class PriorityChoose extends StatelessWidget {
  const PriorityChoose({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(kborderSize),
      child: MaterialButton(
          padding: const EdgeInsets.all(15),
          color: priorityColor,
          onPressed: () {
            showMenu(
                context: context,
                popUpAnimationStyle: AnimationStyle(curve: Curves.bounceIn),
                items: [
                  const PopupMenuItem(child: Text("Low Priority")),
                  const PopupMenuItem(child: Text("Medium Priority")),
                  const PopupMenuItem(child: Text("High Priority"))
                ],
                constraints: const BoxConstraints.expand(height: 150),
                position: RelativeRect.fromLTRB(
                    0, MediaQuery.of(context).size.height / 1.5, 0, 0));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.flag, size: 40, color: mainColor),
                  Container(width: 5),
                  Text(
                    "Medium Priority",
                    style: TextStyle(
                      fontSize: 20,
                      color: mainColor,
                    ),
                  ),
                ],
              ),
              Icon(Icons.arrow_downward, color: mainColor),
            ],
          )),
    );
  }
}
