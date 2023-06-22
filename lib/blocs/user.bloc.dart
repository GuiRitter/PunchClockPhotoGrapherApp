import 'dart:io';

import 'package:flutter/material.dart';
import 'package:punch_clock_photo_grapher_mobile_bloc/models/sign_in.model.dart';
import 'package:punch_clock_photo_grapher_mobile_bloc/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserBloc extends ChangeNotifier {
  String? token;
  bool isLoading = false;

  final _api = Settings.api;

  Future<void> signIn(
    SignInModel signInModel,
  ) async {
    try {
      var prefs = await SharedPreferences.getInstance();
      prefs.setString(
        Settings.token,
        "",
      );

      isLoading = true;
      notifyListeners();

      final response = await _api.post(
        Settings.apiSignInUrl,
        data: signInModel.toJson(),
      );

      isLoading = false;
      notifyListeners();

      if ((response.statusCode != HttpStatus.ok) ||
          (response.data is! Map) ||
          (!(response.data as Map).containsKey(
            "data",
          )) ||
          ((response.data as Map)["data"] is! Map) ||
          (!((response.data as Map)["data"] as Map).containsKey(
            "token",
          ))) {
        throw response;
      }

      token = response.data["data"]["token"];
      prefs.setString(
        Settings.token,
        token!,
      );

      notifyListeners();
    } catch (_) {
      isLoading = false;
      notifyListeners();
      rethrow;
    }
  }
}
