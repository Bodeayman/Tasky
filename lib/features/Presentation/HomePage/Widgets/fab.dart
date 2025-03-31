import 'package:flutter/material.dart';

class Fab extends StatelessWidget {
  final VoidCallback onFirstButtonPressed;
  final VoidCallback onSecondButtonPressed;

  const Fab(
      {super.key,
      required this.onFirstButtonPressed,
      required this.onSecondButtonPressed});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // First FAB (existing one)
        Positioned(
          bottom: 10, // Adjust the position as needed
          right: 10, // Adjust the position as needed
          child: FloatingActionButton(
            onPressed:
                onFirstButtonPressed, // Make sure this calls the callback correctly
            backgroundColor: const Color(0xFF5F33E1),
            shape: const CircleBorder(),
            elevation: 10,
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ),
        // Second FAB (new one)
        Positioned(
          bottom: 70,
          right: 10,
          child: FloatingActionButton(
            mini: true,
            onPressed:
                onSecondButtonPressed, // Make sure this calls the callback correctly
            backgroundColor: const Color(0xFFFF5733),
            shape: const CircleBorder(),
            elevation: 10,
            child: const Icon(Icons.edit, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
