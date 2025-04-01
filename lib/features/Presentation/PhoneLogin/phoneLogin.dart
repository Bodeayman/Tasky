import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasky/features/Presentation/PhoneLogin/Widgets/phoneLoginForm.dart';

class Phonelogin extends StatefulWidget {
  const Phonelogin({super.key});

  @override
  State<Phonelogin> createState() => _PhoneloginState();
}

class _PhoneloginState extends State<Phonelogin> {
  final String assetName = 'assets/ART.svg';

  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Image.asset("assets/girlImage.png")),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: PhoneLoginForm(formkey: _formkey),
            )
          ],
        ),
      ),
    );
  }
}
