import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:tasky/core/utils/url.dart';

part 'sign_page_state.dart';

class SignPageCubit extends Cubit<SignPageState> {
  SignPageCubit() : super(SignPageInitial());
  Future<void> addNewUser(String phone, String pass, String name, String exp,
      String address, String choosenExp) async {
    try {
      emit(SignPageLoading());
      final response =
          await http.post(Uri.parse('$baseUrl/auth/register'), body: {
        "phone": phone,
        "password": pass,
        "displayName": name,
        "experienceYears": exp,
        "address": address,
        "level": choosenExp,
      });
      if (response.statusCode != 201 || response.statusCode == 200) {
        throw Exception(
          "Something has occured wrong in the signin up process",
        );
      }
    } catch (e) {
      debugPrint(
        e.toString(),
      );
    }
  }
}
