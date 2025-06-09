part of 'profile_loading_cubit.dart';

@immutable
sealed class ProfileLoadingState {}

final class ProfileLoadingInitial extends ProfileLoadingState {}

final class ProfileLoadingLoaded extends ProfileLoadingState {
  final User user;
  ProfileLoadingLoaded(this.user);
}

final class ProfileLoadingError extends ProfileLoadingState {
  final String error;
  ProfileLoadingError(this.error);
}
