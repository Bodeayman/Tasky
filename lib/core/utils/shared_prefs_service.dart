import 'package:shared_preferences/shared_preferences.dart';

Future<bool> onBoarding() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool("onBoard") ?? false;
}

void setOnBoarding(bool value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool("onBoard", value);
}

Future<void> saveTokens(String accessToken, String refreshToken) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('access_token', accessToken);
  await prefs.setString('refresh_token', refreshToken);
}

Future<String?> getAccessToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('access_token');
}

Future<void> clearTokens() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('access_token');
  await prefs.remove('refresh_token');
}
