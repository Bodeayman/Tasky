import 'package:flutter/material.dart';
import 'package:tasky/core/utils/constants.dart';
import 'package:tasky/features/Presentation/HomePage/homePage.dart';

class SignInButton extends StatefulWidget {
  const SignInButton({super.key, required this.formkey});
  final GlobalKey<FormState> formkey;
  @override
  State<SignInButton> createState() => _SignInButtonState();
}

class _SignInButtonState extends State<SignInButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(kborderSize),
          child: MaterialButton(
            padding: const EdgeInsets.symmetric(horizontal: 110, vertical: 20),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: const Color(0xFF5F33E1),
            onPressed: () {
              if (widget.formkey.currentState!.validate()) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                );
              }
            },
            child: const Text(
              "Sign In",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
