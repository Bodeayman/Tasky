import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:tasky/features/ProfilePage/Data/Models/User.dart';
import 'package:tasky/features/ProfilePage/Data/Repo/ProfileRepo.dart';

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
