import 'package:flutter/material.dart';
import 'package:tasky/features/Presentation/HomePage/homePage.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  List<String> titleFields = [
    "NAME",
    "PHONE",
    "LEVEL",
    "YEARS OF EXPERIENCE",
    "LOCATION"
  ];
  List<String> testFields = [
    "Islam Sayed",
    "+20 123 456-7890",
    "Senior",
    "7 years",
    "Fayyum, Egypt"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                );
              },
            ),
            const Text(
              "Profile",
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              // Wrap the ListView inside Expanded
              child: ListView.builder(
                itemCount: titleFields
                    .length, // Use titleFields.length to ensure the data aligns
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(
                        bottom: 10), // Add some margin between items
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F0F0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          titleFields[index], // Dynamic field names
                          style: const TextStyle(
                              fontSize: 15, color: Color(0xFFA6A6A6)),
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          testFields[index], // Dynamic field values
                          maxLines: 1,
                          style: const TextStyle(
                              color: Color(0xFF7E7E7E),
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      trailing: (index == 2)
                          ? IconButton(
                              icon: const Icon(Icons.copy),
                              onPressed: () {},
                            )
                          : null,
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
