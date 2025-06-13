import 'package:flutter/material.dart';
import 'package:tasky/core/utils/constants.dart';
import 'package:tasky/core/utils/shared_prefs_service.dart';
import 'package:tasky/core/utils/style/colors.dart';
// ignore: depend_on_referenced_packages
import 'package:tasky/features/PhoneLogin/Presentation/Views/phoneLogin.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IntroductionPage extends StatelessWidget {
  const IntroductionPage({super.key});
  final String assetName = 'assets/art.svg';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Image.asset(
                "assets/girlImage.png",
              ),
            ),
            // Container(height: 350), // For phone
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  const Text(
                    "Task Managmenet & To-Do List",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(height: 20),
                  Text(
                    textAlign: TextAlign.center,
                    style: TextStyle(color: textFieldsColor),
                    "This productive tool is designed to help you better manage your task , project-wise conveniently",
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(kborderSize),
                          child: MaterialButton(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 80, vertical: 20),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            color: const Color(0xFF5F33E1),
                            onPressed: () async {
                              await setOnBoarding(true);
                              bool onBoardingVar = await onBoarding();
                              debugPrint(onBoardingVar.toString());

                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => const Phonelogin(),
                                ),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Let's Start ",
                                  style: TextStyle(color: Colors.white),
                                ),
                                const SizedBox(
                                  width: 25,
                                ),
                                Transform(
                                  transform: Matrix4.rotationY(3.1416),
                                  child: Image.asset("assets/arrow_left.png",
                                      alignment: Alignment.center,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 20,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
