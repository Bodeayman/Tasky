import 'package:flutter/material.dart';
import 'package:tasky/core/utils/constants.dart';
import 'package:tasky/features/Presentation/HomePage/Presentation/Views/homePage.dart';

class SignInButton extends StatefulWidget {
  const SignInButton({super.key, required this.formkey});
  final GlobalKey<FormState> formkey;
  @override
  State<SignInButton> createState() => _SignInButtonState();
}

class _SignInButtonState extends State<SignInButton> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
