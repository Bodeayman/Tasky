import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:tasky/features/Presentation/ProfilePage/Data/Models/User.dart';
import 'package:tasky/core/utils/constants.dart';
import 'package:tasky/core/utils/refresh_token.dart';
import 'package:tasky/core/utils/shared_prefs_service.dart';
import 'package:tasky/core/utils/url.dart';
import 'package:tasky/features/Presentation/ProfilePage/Data/Repo/ProfileRepo.dart';
import 'package:tasky/features/Presentation/QrScanner/Views/qr_scanner_view.dart';

part 'profile_loading_state.dart';

class ProfileLoadingCubit extends Cubit<ProfileLoadingState> {
  ProfileLoadingCubit(this.profileRepo) : super(ProfileLoadingInitial());
  final ProfileRepo profileRepo;
  void fetchingUsersData() async {
    var result = await profileRepo.fetchingUsersData();
    result.fold(
      (failure) => emit(
        ProfileLoadingError(
          failure,
        ),
      ),
      (user) => emit(
        ProfileLoadingLoaded(
          user,
        ),
      ),
    );
  }
}
