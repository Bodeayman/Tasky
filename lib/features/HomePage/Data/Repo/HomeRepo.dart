import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tasky/core/utils/refresh_token.dart';
import 'package:tasky/core/utils/shared_prefs_service.dart';
import 'package:tasky/core/utils/url.dart';
import 'package:tasky/features/HomePage/Data/Models/Task.dart';
import 'package:dartz/dartz.dart';

class HomeRepo {
  Future<Either<String, List<TaskModel>>> fetchTasks(
      {required int page}) async {
    try {
      final token = await getAccessToken();

      final response = await http.get(
        Uri.parse('$baseUrl/todos?page=$page'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode != 200) {
        await refreshAccessToken();
        final token = await getAccessToken();
        final response = await http.get(
          Uri.parse('$baseUrl/todos?page=$page'),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        );
        debugPrint(response.body.toString());

        if (response.statusCode != 200) {
          throw Exception(
            "Failed to load tasks, Maybe an Authentication Problem",
          );
        }
      }

      final List<dynamic> data = jsonDecode(response.body);
      final tasks = data.map((json) => TaskModel.fromJson(json)).toList();

      return right(tasks);
    } catch (e) {
      return left(
        (e.toString()),
      );
    }
  }
}
