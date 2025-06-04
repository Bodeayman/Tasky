import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:tasky/core/models/User.dart';
import 'package:tasky/core/utils/constants.dart';
import 'package:tasky/core/utils/shared_prefs_service.dart';
import 'package:tasky/core/utils/url.dart';
import 'package:tasky/features/Presentation/QrScanner/Views/qr_scanner_view.dart';

part 'profile_loading_state.dart';

class ProfileLoadingCubit extends Cubit<ProfileLoadingState> {
  ProfileLoadingCubit() : super(ProfileLoadingInitial());
  void fetchingUsersData() async {
    try {
      final token = await getAccessToken();
      debugPrint(token);
      final response = await http.get(
        Uri.parse('$baseUrl/auth/profile'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json', // Optional but recommended
        },
      );
      if (response.statusCode == 401) {
        throw Exception();
      }
      final data = jsonDecode(response.body);
      print(data);
      User user = User(data["displayName"], data["username"], data["level"],
          data["address"], data["experienceYears"]);
      print(user);
      emit(ProfileLoadingLoaded(user));
    } catch (e) {
      emit(ProfileLoadingError(e.toString()));
    }
  }
}
