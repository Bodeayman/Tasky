import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tasky/core/utils/refresh_token.dart';
import 'package:tasky/core/utils/shared_prefs_service.dart';
import 'package:tasky/core/utils/url.dart';
import 'package:tasky/features/HomePage/Data/Models/Task.dart';

Future<TaskModel?> fetchTaskById(String id) async {
  try {
    final token = await getAccessToken();
    final response = await http.get(
      Uri.parse('$baseUrl/todos/$id'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 401) {
      await refreshAccessToken();
      throw Exception("Unauthorized. Try again.");
    }

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      return TaskModel.fromJson(json);
    } else {
      print('Failed to fetch task: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print('Error: $e');
    return null;
  }
}
