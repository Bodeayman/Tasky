import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:tasky/core/utils/refresh_token.dart';
import 'package:tasky/core/utils/shared_prefs_service.dart';
import 'package:tasky/core/utils/url.dart';
import 'package:tasky/features/ProfilePage/Data/Models/User.dart';

class ProfileRepo {
  Future<Either<String, User>> fetchingUsersData() async {
    try {
      final token = await getAccessToken();
      final response = await http.get(
        Uri.parse('$baseUrl/auth/profile'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 401) {
        await refreshAccessToken();
        final response = await http.get(
          Uri.parse('$baseUrl/auth/profile'),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        );
        if (response.statusCode == 401) {
          throw Exception("Unauthorized, Please login again");
        }
      }
      final data = jsonDecode(response.body);
      User user = User(data["displayName"], data["username"], data["level"],
          data["address"], data["experienceYears"]);
      return right(user);
    } catch (e) {
      return left(e.toString());
    }
  }
}
