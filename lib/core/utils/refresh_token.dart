import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/core/utils/constants.dart';
import 'package:tasky/core/utils/url.dart';

Future<bool> refreshAccessToken() async {
  final prefs = await SharedPreferences.getInstance();
  final refreshToken = prefs.getString('refresh_token');

  if (refreshToken == null) return false;

  final response = await http.get(
    Uri.parse('$baseUrl/auth/refresh-token?token=$refreshToken'),
    headers: {'Content-Type': 'application/json'},
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final newAccessToken = data['access_token'];
    debugPrint("this is coming from the debugger itself");
    debugPrint(newAccessToken);

    if (newAccessToken != null) {
      await prefs.setString('access_token', newAccessToken);
      return true;
    }
  }

  return false;
}
