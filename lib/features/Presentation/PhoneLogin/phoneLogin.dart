// ignore: file_names
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky/features/Presentation/SignUpPage/SignPage.dart';
import 'package:tasky/core/utils/constants.dart';
import 'package:tasky/features/Presentation/HomePage/homePage.dart';
import 'package:tasky/core/utils/style/inputStyle.dart';

class Phonelogin extends StatefulWidget {
  const Phonelogin({super.key});

  @override
  State<Phonelogin> createState() => _PhoneloginState();
}

class _PhoneloginState extends State<Phonelogin> {
  final String assetName = 'assets/art.svg';

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  bool seePass = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Container(
                  color: Colors.black,
                  width: 200,
                  height: 150,
                )
                //   SvgPicture.asset(
                //   assetName,
                //   semanticsLabel: 'Acme Logo',

                // ),

                /*Remember don't include the single child view page if you want the scrollpageview to work */
                ),
            Container(height: 250),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  const SizedBox(
                    width: 275,
                    child: Text(
                      "Login",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(height: 20),
                  /* The work field will be here */
                  SizedBox(
                    width: 300,
                    child: Column(children: [
                      TextFormField(
                        validator: (value) {
                          return null;
                        },
                        decoration: inputStyle.copyWith(
                          hintText: "123-456-7890",
                          hintStyle:
                              const TextStyle(fontWeight: FontWeight.w100),
                          prefixIcon: InkWell(
                            onTap: () {
                              showMenu(
                                context: context,
                                position: RelativeRect.fromSize(
                                    Rect.fromCenter(
                                        center: Offset.infinite,
                                        width: 360,
                                        height: 150),
                                    Size.infinite),
                                items: [
                                  const PopupMenuItem(
                                    child: Text("Egypt"),
                                  ),
                                ],
                              );
                            },
                            child: const SizedBox(
                              width: 60,
                              child: Row(
                                children: [
                                  Icon(Icons.flag),
                                  Text("+20"),
                                  Text(">")
                                ],
                              ),
                            ),
                          ),
                        ),
                        controller: phoneController,
                      ),
                      Container(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: inputStyle.copyWith(
                          hintText: "Password...",
                          suffixIcon: IconButton(
                            icon: Icon(
                              seePass
                                  ? Icons.remove_red_eye
                                  : Icons.remove_red_eye_outlined,
                            ),
                            onPressed: () {
                              setState(() {
                                seePass = !seePass;
                              });
                            },
                          ),
                        ),
                        obscureText: !seePass,
                        controller: passwordController,
                      ),
                      Container(
                        height: 20,
                      ),
                    ]),
                  ),
                  /* The work field will be here */

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
                              horizontal: 110, vertical: 20),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          color: const Color(0xFF5F33E1),
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const HomePage(),
                              ),
                            );
                          },
                          child: const Text(
                            "Sign In",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Didn't have any account"),
                      Container(width: 1),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => SignPage(),
                            ),
                          );
                        },
                        child: const Text(
                          "Sign Up here",
                          style:
                              TextStyle(decoration: TextDecoration.underline),
                        ),
                      )
                    ],
                  ),
                  Container(height: 20),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
