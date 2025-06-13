import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/core/utils/navigator_service.dart';
import 'package:tasky/core/utils/shared_prefs_service.dart';
import 'package:tasky/core/utils/url.dart';
import 'package:tasky/features/PhoneLogin/Presentation/Views/phoneLogin.dart';

Future<bool> refreshAccessToken() async {
  String? refreshToken = await getRefreshToken();
  debugPrint(refreshToken);
  if (refreshToken == null) {
    navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (context) => const Phonelogin(),
      ),
    );
    return false;
  }
  final response = await http.get(
    Uri.parse('$baseUrl/auth/refresh-token?token=$refreshToken'),
    headers: {'Content-Type': 'application/json'},
  );
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final newAccessToken = data['access_token'];

    if (newAccessToken != null) {
      await saveTokens(newAccessToken, refreshToken);
      return true;
    }
  }

  return false;
}
