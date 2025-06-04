import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tasky/core/utils/constants.dart';
import 'package:tasky/core/utils/shared_prefs_service.dart';
import 'package:tasky/core/utils/style/colors.dart';
import 'package:tasky/core/utils/style/inputStyle.dart';
import 'package:tasky/core/utils/url.dart';
import 'package:tasky/features/Presentation/HomePage/Presentation/Views/homePage.dart';
import 'package:tasky/features/Presentation/SignUpPage/Views/SignPage.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

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
              IntlPhoneField(
                controller: phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(kborderSize),
                      borderSide:
                          BorderSide(color: inputFieldBorderColor, width: 1)),
                  prefixIcon: InkWell(
                    onTap: () {
                      print("Tapped the prefix icon");
                    },
                    child: const SizedBox(
                      width: 70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.flag,
                              size: 20), // You can replace with actual flag
                          SizedBox(width: 4),
                          Text("+20",
                              style: TextStyle(fontWeight: FontWeight.w500)),
                          SizedBox(width: 4),
                          Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    ),
                  ),
                ),
                initialCountryCode: 'EG', // Egypt as example

                validator: (phone) {
                  if (phone == null || phone.number.isEmpty) {
                    return 'Phone Number required';
                  }
                  return null;
                },
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
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(kborderSize),
                child: MaterialButton(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 110, vertical: 20),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: const Color(0xFF5F33E1),
                  onPressed: () async {
                    if (widget.formkey.currentState!.validate()) {
                      try {
                        debugPrint(phoneController.text);
                        debugPrint(passwordController.text);

                        final response = await http
                            .post(Uri.parse('$baseUrl/auth/login'), body: {
                          "phone": phoneController.text,
                          "password": passwordController.text,
                        });
                        if (response.statusCode == 401) {
                          throw Exception(
                              "There's a problem in password or the name");
                        }

                        final data = jsonDecode(response.body);
                        debugPrint(data["access_token"]);
                        debugPrint(data["refresh_token"]);
                        saveTokens(data["access_token"], data["refresh_token"]);
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Successful")));
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.toString())));
                      }
                    }
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
                builder: (context) => const SignPage(),
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
