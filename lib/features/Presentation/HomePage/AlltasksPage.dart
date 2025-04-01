import 'package:flutter/material.dart';
import 'package:tasky/features/Presentation/TaskDetails/TaskDetails.dart';

class Alltaskspage extends StatelessWidget {
  const Alltaskspage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: ListTile(
        title: Row(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                height: 100,
                decoration: const BoxDecoration(color: Colors.amber),
                child: const Center(
                  child: Text("Image here"),
                ),
              ),
            ),
            Container(width: 20),
            const Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Grocery Shopping",
                  ),
                  Text("The application is designed for s.."),
                  Row(
                    children: [
                      Icon(Icons.flag),
                      Text("Medium"),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const TaskDetails(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
