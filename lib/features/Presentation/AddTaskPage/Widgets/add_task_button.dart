import 'package:flutter/material.dart';
import 'package:tasky/core/utils/style/colors.dart';

class AddTaskButton extends StatelessWidget {
  const AddTaskButton({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.all(10),
        side: BorderSide(
            color: mainColor,
            width: 2,
            style: BorderStyle.values[0]), // Border color and width
      ),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return const Dialog(
              child: SizedBox(
                width: 350,
                height: 150,
                child: Center(
                  child: Text("We didn't implement the feature yet"),
                ),
              ),
            );
          },
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.photo, color: mainColor, size: 35),
          Container(width: 20),
          Text(
            "Add Img",
            style: TextStyle(color: mainColor, fontSize: 20),
          ),
        ],
      ),
    );
  }
}
