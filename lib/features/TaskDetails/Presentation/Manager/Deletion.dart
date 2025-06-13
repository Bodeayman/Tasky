import 'package:http/http.dart' as http;
import 'package:tasky/core/utils/refresh_token.dart';
import 'package:tasky/core/utils/shared_prefs_service.dart';
import 'package:tasky/core/utils/url.dart';

Future<void> DeleteTask(String id) async {
  final token = await getAccessToken();
  final response = await http.delete(
    Uri.parse('$baseUrl/todos/$id'),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );
  if (response.statusCode == 401) {
    await refreshAccessToken();
    throw Exception("Failed to Delete the Task, Please Try again");
  }
}
