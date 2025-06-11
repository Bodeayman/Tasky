import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const secureStorage = FlutterSecureStorage();

Future<void> saveTokens(String accessToken, String refreshToken) async {
  await secureStorage.write(key: 'access_token', value: accessToken);
  await secureStorage.write(key: 'refresh_token', value: refreshToken);
}

Future<String?> getAccessToken() async {
  return await secureStorage.read(key: 'access_token');
}

Future<String?> getRefreshToken() async {
  return await secureStorage.read(key: 'refresh_token');
}

Future<void> clearTokens() async {
  await secureStorage.delete(key: 'access_token');
  await secureStorage.delete(key: 'refresh_token');
}

Future<bool> onBoarding() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool("onBoard") ?? false;
}

/// Set onboarding flag
Future<void> setOnBoarding(bool value) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool("onBoard", value);
}
