import 'package:flutter/material.dart';
import 'package:tasky/core/utils/constants.dart';
import 'package:tasky/core/utils/style/colors.dart';
import 'package:tasky/features/Presentation/AddTaskPage/AddTaskPage.dart';

class Fab extends StatelessWidget {
  const Fab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // First FAB (existing one)
        Positioned(
          bottom: 10, // Adjust the position as needed
          right: 10, // Adjust the position as needed
          child: FloatingActionButton(
            onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const AddTaskPage())),
            backgroundColor: const Color(0xFF5F33E1),
            shape: const CircleBorder(),
            elevation: 10,
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ),
        // Second FAB (new one)
        Positioned(
          bottom: 75,
          right: 19,
          child: InkWell(
            borderRadius: BorderRadius.circular(15),
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                  color: priorityColor,
                  borderRadius: BorderRadius.circular(500)),
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    "assets/qrCode.png",
                    width: iconsSize,
                    height: iconsSize,
                  )),
            ),
          ),
        ),
      ],
    );
  }
}
