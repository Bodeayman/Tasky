import 'package:flutter/material.dart';

ListTile taskTile = ListTile(
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
          icon: Icon(Icons.menu),
          onPressed: () {
            print("Nothing");
          },
        ),
      ),
    ],
  ),
);
