import 'package:flutter/material.dart';
import 'package:tasky/core/utils/style/inputStyle.dart';
import 'package:tasky/features/Presentation/PhoneLogin/Widgets/sign_in_button.dart';
import 'package:tasky/features/Presentation/SignUpPage/SignPage.dart';

class PhoneLoginForm extends StatefulWidget {
  const PhoneLoginForm({super.key, required this.formkey});
  final GlobalKey<FormState> formkey;

  @override
  State<PhoneLoginForm> createState() => _PhoneLoginFormState();
}

class _PhoneLoginFormState extends State<PhoneLoginForm> {
  bool seePass = false;

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  final String phoneRegex =
      r'^\+(\d{1,4})[-.\s]?\(?\d{1,4}\)?[-.\s]?\d{1,4}[-.\s]?\d{1,4}$';
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formkey,
      child: Column(
        children: [
          const LoginLogoInPhoneForm(),
          Container(height: 20),
          SizedBox(
            width: 300,
            child: Column(children: [
              TextFormField(
                validator: (val) {
                  if (val!.trim() == "" || val.isEmpty) {
                    return "Please enter a valid phone number";
                  }
                  final phoneReg = RegExp(phoneRegex);
                  if (!phoneReg.hasMatch(val)) {
                    return 'Enter a valid phone number';
                  }
                  return null;
                },
                decoration: inputStyle.copyWith(
                  hintText: "123-456-7890",
                  hintStyle: const TextStyle(fontWeight: FontWeight.w100),
                  prefixIcon: InkWell(
                    onTap: () {
                      showMenu(
                        context: context,
                        position: RelativeRect.fromLTRB(
                            0,
                            MediaQuery.of(context).size.height / 1.5,
                            MediaQuery.of(context).size.width,
                            0),
                        items: [
                          const PopupMenuItem(
                            child: Text("Egypt"),
                          ),
                          const PopupMenuItem(
                            child: Text("Saudi Arabia"),
                          ),
                          const PopupMenuItem(
                            child: Text("UAE"),
                          ),
                        ],
                      );
                    },
                    child: const SizedBox(
                      width: 60,
                      child: Row(
                        children: [Icon(Icons.flag), Text("+20"), Text(">")],
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
                validator: (val) {
                  if (val!.trim() == "" || val.isEmpty) {
                    return "Please enter a valid password";
                  }
                  return null;
                },
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
          SignInButton(formkey: widget.formkey),
          Container(
            height: 5,
          ),
          const DidnotHaveAccountPhoneForm(),
          Container(height: 20),
        ],
      ),
    );
  }
}

class LoginLogoInPhoneForm extends StatelessWidget {
  const LoginLogoInPhoneForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      child: Align(
        alignment: Alignment.centerLeft,
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
    );
  }
}

class DidnotHaveAccountPhoneForm extends StatelessWidget {
  const DidnotHaveAccountPhoneForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
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
            style: TextStyle(decoration: TextDecoration.underline),
          ),
        )
      ],
    );
  }
}
