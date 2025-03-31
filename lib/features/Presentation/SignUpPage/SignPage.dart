// ignore: file_names
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky/features/Presentation/PhoneLogin/phoneLogin.dart';
import 'package:tasky/core/utils/style/inputStyle.dart';
import 'package:http/http.dart' as http;

class SignPage extends StatelessWidget {
  SignPage({super.key});
  final String assetName = 'assets/art.svg';
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController expController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: SvgPicture.asset(
              assetName,
              semanticsLabel: 'Acme Logo',
              width: 200,
              height: 50,
            ),
          ),
          Container(height: 20),
          Padding(
            padding: const EdgeInsets.all(15.0),
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
                    TextField(
                      decoration: inputStyle.copyWith(hintText: "Name...."),
                    ),
                    Container(
                      height: 10,
                    ),
                    TextField(
                      decoration: inputStyle.copyWith(
                        hintText: "123-456-7890",
                        hintStyle: const TextStyle(fontWeight: FontWeight.w100),
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
                    ),
                    Container(
                      height: 10,
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      decoration: inputStyle.copyWith(
                          hintText: "Years of experience..."),
                      controller: expController,
                    ),
                    Container(height: 10),
                    TextField(
                      decoration: inputStyle.copyWith(
                          hintText: "Choose your level of exp..."),
                    ),
                    Container(height: 10),
                    TextField(
                        decoration: inputStyle.copyWith(hintText: "Address..."),
                        controller: addressController),
                    Container(height: 10),
                    TextField(
                      decoration: inputStyle.copyWith(
                        hintText: "Password...",
                        suffixIcon: const Icon(Icons.remove_red_eye),
                      ),
                      obscureText: true,
                      controller: passwordController,
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
                    child: MaterialButton(
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 100, vertical: 20),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      color: const Color(0xFF5F33E1),
                      onPressed: () async {
                        dynamic response;
                        try {
                          response = await http
                              .get(Uri.parse("http://127.0.0.1:8000/posts"));
                        } catch (e) {
                          print("Can't fetch the data");
                          response.body = "Invalid";
                        }
                        print(response.body);
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(color: Colors.white),
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
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                    )
                  ],
                ),
                Container(height: 10),
              ],
            ),
          )
        ],
      ),
    );
  }
}
