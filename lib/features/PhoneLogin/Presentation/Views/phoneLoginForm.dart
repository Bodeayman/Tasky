import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/utils/constants.dart';
import 'package:tasky/core/utils/style/colors.dart';
import 'package:tasky/core/utils/style/inputStyle.dart';
import 'package:tasky/features/HomePage/Presentation/Views/homePage.dart';
import 'package:tasky/features/PhoneLogin/Presentation/Manager/phone_login_cubit.dart';
import 'package:tasky/features/SignUpPage/Presentation/Views/SignPage.dart';
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
            child: Column(
              children: [
                SizedBox(
                  child: IntlPhoneField(
                    showCountryFlag: true,
                    controller: phoneController,
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(kborderSize),
                        borderSide:
                            BorderSide(color: inputFieldBorderColor, width: 1),
                      ),
                    ),
                    initialCountryCode: 'EG',
                    validator: (phone) {
                      if (phone == null || phone.number.isEmpty) {
                        return 'Phone Number required';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  height: 20,
                ),
                SizedBox(
                  child: TextFormField(
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
                ),
                Container(
                  height: 20,
                ),
              ],
            ),
          ),
          /* The work field will be here */
          SizedBox(
            width: 335,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(kborderSize),
                  child: BlocBuilder<PhoneLoginCubit, PhoneLoginState>(
                    builder: (context, state) {
                      return MaterialButton(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 110,
                          vertical: 20,
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        color: const Color(0xFF5F33E1),
                        onPressed: () async {
                          if (widget.formkey.currentState!.validate()) {
                            try {
                              await context.read<PhoneLoginCubit>().phoneLogin(
                                    phoneController.text,
                                    passwordController.text,
                                  );
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Successful"),
                                ),
                              );
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => const HomePage(),
                                ),
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    e.toString(),
                                  ),
                                ),
                              );
                            }
                          }
                        },
                        child: (state is PhoneLoginLoading)
                            ? const SizedBox(
                                height: 30,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Sign In",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              )
                            : const Text(
                                "Sign In",
                                style: TextStyle(color: Colors.white),
                              ),
                      );
                    },
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
