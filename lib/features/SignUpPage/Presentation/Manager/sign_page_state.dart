part of 'sign_page_cubit.dart';

@immutable
sealed class SignPageState {}

final class SignPageInitial extends SignPageState {}

final class SignPageLoading extends SignPageState {}
