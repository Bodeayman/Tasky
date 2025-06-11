import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:tasky/core/utils/shared_prefs_service.dart';
import 'package:tasky/core/utils/url.dart';

part 'phone_login_state.dart';

class PhoneLoginCubit extends Cubit<PhoneLoginState> {
  PhoneLoginCubit() : super(PhoneLoginInitial());
  Future<void> phoneLogin(String phone, String password) async {
    try {
      emit(PhoneLoginLoading());

      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'phone': phone,
          'password': password,
        },
      );

      if (response.statusCode == 401) {
        final error = jsonDecode(response.body);
        throw Exception(error['message'] ?? 'Incorrect phone or password');
      }

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final data = jsonDecode(response.body);

        final accessToken = data['access_token'];
        final refreshToken = data['refresh_token'];

        if (accessToken != null && refreshToken != null) {
          await saveTokens(accessToken, refreshToken);
        } else {
          emit(PhoneLoginInitial());
          throw Exception('Missing token data from response.');
        }
      } else {
        emit(PhoneLoginInitial());

        throw Exception(
            'Login failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      emit(PhoneLoginInitial());

      throw Exception(e.toString());
    }
  }
}
