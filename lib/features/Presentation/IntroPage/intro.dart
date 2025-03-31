import 'package:flutter/material.dart';
import 'package:tasky/core/utils/constants.dart';
// ignore: depend_on_referenced_packages
import 'package:tasky/features/Presentation/PhoneLogin/phoneLogin.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IntroductionPage extends StatelessWidget {
  const IntroductionPage({super.key});
  final String assetName = 'assets/art.svg';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: SvgPicture.asset(
              assetName,
              semanticsLabel: 'Acme Logo',
              width: 200,
              height: 150,
            ),
          ),
          // Container(height: 350), // For phone
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                const Text(
                  "Task Managmenet &        To-Do List",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold),
                ),
                Container(height: 20),
                const Text(
                  textAlign: TextAlign.center,
                  "This productive tool is designed to help you better manage your task , project-wise conveniently",
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(kborderSize),
                      child: MaterialButton(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 80, vertical: 20),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        color: const Color(0xFF5F33E1),
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const Phonelogin(),
                            ),
                          );
                        },
                        child: const Text(
                          "Let's Start ->",
                          style: TextStyle(color: Colors.white),
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
    );
  }
}
