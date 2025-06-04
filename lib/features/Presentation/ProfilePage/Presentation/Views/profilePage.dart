import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/utils/style/colors.dart' show mainColor;
import 'package:tasky/features/Presentation/ProfilePage/Presentation/Manager/profile_loading_cubit.dart';

// ignore: must_be_immutable
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
    ".......",
    ".......",
    ".......",
    ".......",
    "......."
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: BlocBuilder<ProfileLoadingCubit, ProfileLoadingState>(
          builder: (context, state) {
            if (state is ProfileLoadingInitial) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ProfileLoadingError) {
              return Center(
                child: Text(state.error),
              );
            } else if (state is ProfileLoadingLoaded) {
              /*
                        "NAME",
          "PHONE",
          "LEVEL",
          "YEARS OF EXPERIENCE",
          "LOCATION"
                     */
              testFields[0] = state.user.name;
              testFields[1] = state.user.phone;
              testFields[2] = state.user.level;
              testFields[3] = state.user.experienceYears.toString();
              testFields[4] = state.user.address;

              return Column(
                children: [
                  Expanded(
                    // Wrap the ListView inside Expanded
                    child: ListView.builder(
                      itemCount:
                          5, // Use titleFields.length to ensure the data aligns
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                titleFields[index], // Dynamic field names
                                style: const TextStyle(
                                    fontSize: 15, color: Color(0xFFA6A6A6)),
                              ),
                            ),
                            subtitle: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
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
                                    icon: Icon(Icons.copy, color: mainColor),
                                    onPressed: () {},
                                  )
                                : null,
                          ),
                        );
                      },
                    ),
                  )
                ],
              );
            } else {
              return const Center(
                child: Text("Unknown Error"),
              );
            }
          },
        ),
      ),
    );
  }
}
