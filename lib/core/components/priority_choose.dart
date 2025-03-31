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
          onPressed: () {},
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
