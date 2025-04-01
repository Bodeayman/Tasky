import 'package:shared_preferences/shared_preferences.dart';

Future<bool> onBoarding() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool("onBoard") ?? false;
}

void setOnBoarding(bool value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool("onBoard", value);
}
