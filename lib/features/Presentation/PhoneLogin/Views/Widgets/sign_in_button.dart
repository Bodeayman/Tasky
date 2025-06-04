import 'package:flutter/material.dart';

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
