import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tasky/core/utils/shared_prefs_service.dart';
import 'package:tasky/core/utils/url.dart';

void phoneLogin(String phone, String password) async {
  final response = await http.post(Uri.parse('$baseUrl/auth/login'), body: {
    "phone": phone,
    "password": password,
  });
  if (response.statusCode == 401) {
    throw Exception(
      "There's a problem in password or the name",
    );
  }
  final data = jsonDecode(response.body);
  saveTokens(data["access_token"], data["refresh_token"]);
}
