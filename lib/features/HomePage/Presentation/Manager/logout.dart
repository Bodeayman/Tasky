import 'package:http/http.dart' as http;
import 'package:tasky/core/utils/refresh_token.dart';
import 'package:tasky/core/utils/shared_prefs_service.dart';
import 'package:tasky/core/utils/url.dart';

Future<void> loggingOut() async {
  final token = await getAccessToken();

  final response = await http.post(
    Uri.parse('$baseUrl/auth/logout'),
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
  );
  if (response.statusCode != 200) {
    await refreshAccessToken();
    final token = await getAccessToken();

    final response = await http.post(
      Uri.parse('$baseUrl/auth/logout'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 401) {
      throw Exception("Failed to Logout, Try again please");
    }
  }
  await clearTokens();
}
