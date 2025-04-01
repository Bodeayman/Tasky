// ignore: file_names
import 'package:flutter/material.dart';
import 'package:tasky/core/utils/constants.dart';
import 'package:tasky/features/Presentation/HomePage/homePage.dart';
import 'package:tasky/features/Presentation/PhoneLogin/phoneLogin.dart';
import 'package:tasky/core/utils/style/inputStyle.dart';
import 'package:http/http.dart' as http;

class SignPage extends StatefulWidget {
  const SignPage({super.key});

  @override
  State<SignPage> createState() => _SignPageState();
}

class _SignPageState extends State<SignPage> {
  final String assetName = 'assets/art.svg';

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController expController = TextEditingController();

  final TextEditingController addressController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset("assets/girlImage.png"),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Form(
                key: formKey,
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
                          decoration: inputStyle.copyWith(hintText: "Name...."),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "The name field required";
                            }
                            return null;
                          },
                        ),
                        Container(
                          height: 10,
                        ),
                        TextFormField(
                          decoration: inputStyle.copyWith(
                            hintText: "123-456-7890",
                            hintStyle:
                                const TextStyle(fontWeight: FontWeight.w100),
                            prefixIcon: InkWell(
                              onTap: () {
                                print("Tapped the whole icon");
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
                          keyboardType: TextInputType.phone,
                          controller: phoneController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Phone Number required";
                            }
                            return null;
                          },
                        ),
                        Container(
                          height: 10,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: inputStyle.copyWith(
                              hintText: "Years of experience..."),
                          controller: expController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Years of Experience required";
                            }
                            return null;
                          },
                        ),
                        Container(height: 10),
                        TextFormField(
                          decoration: inputStyle.copyWith(
                              hintText: "Choose your level of exp..."),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Your level of experience required";
                            }
                            return null;
                          },
                        ),
                        Container(height: 10),
                        TextFormField(
                          decoration:
                              inputStyle.copyWith(hintText: "Address..."),
                          controller: addressController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Address is required";
                            }
                            return null;
                          },
                        ),
                        Container(height: 10),
                        TextFormField(
                          decoration: inputStyle.copyWith(
                            hintText: "Password...",
                            suffixIcon: const Icon(Icons.remove_red_eye),
                          ),
                          obscureText: true,
                          controller: passwordController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Password is required";
                            }
                            return null;
                          },
                        ),
                        Container(
                          height: 10,
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
                                horizontal: 100, vertical: 20),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            color: const Color(0xFF5F33E1),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const HomePage()));
                              }
                            },
                            child: const Text(
                              "Sign Up",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have any account?"),
                        Container(width: 1),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const Phonelogin(),
                              ),
                            );
                          },
                          child: const Text(
                            "Sign In",
                            style:
                                TextStyle(decoration: TextDecoration.underline),
                          ),
                        )
                      ],
                    ),
                    Container(height: 10),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
