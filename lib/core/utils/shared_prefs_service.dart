import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Initialize secure storage (now works across all platforms if flutter_secure_storage_windows is used)
const FlutterSecureStorage secureStorage = FlutterSecureStorage();

/// Check if user has completed onboarding
Future<bool> onBoarding() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool("onBoard") ?? false;
}

/// Set onboarding flag
Future<void> setOnBoarding(bool value) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool("onBoard", value);
}

/// Save access and refresh tokens
Future<void> saveTokens(String accessToken, String refreshToken) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('access_token', accessToken);
  await secureStorage.write(key: 'refresh_token', value: refreshToken);
}

/// Get access token (from SharedPreferences)
Future<String?> getAccessToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('access_token');
}

/// Get refresh token (from secure storage)
Future<String?> getRefreshToken() async {
  return await secureStorage.read(key: 'refresh_token');
}

/// Clear both tokens
Future<void> clearTokens() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('access_token');
  await secureStorage.delete(key: 'refresh_token');
}
