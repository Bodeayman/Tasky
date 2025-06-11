part of 'phone_login_cubit.dart';

@immutable
sealed class PhoneLoginState {}

final class PhoneLoginInitial extends PhoneLoginState {}

final class PhoneLoginLoading extends PhoneLoginState {}
