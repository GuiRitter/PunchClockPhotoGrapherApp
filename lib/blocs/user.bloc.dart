import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:punch_clock_photo_grapher_mobile_bloc/constants/api_url.dart';
import 'package:punch_clock_photo_grapher_mobile_bloc/constants/settings.dart';
import 'package:punch_clock_photo_grapher_mobile_bloc/models/sign_in.model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserBloc extends ChangeNotifier {
  String? _token;
  bool isLoading = false;

  final _api = Settings.api;

  String? get token => _token;

  clearToken() async {
    _token = null;

    _api.options.headers.remove(
      Settings.token,
    );

    var prefs = await SharedPreferences.getInstance();
    prefs.setString(
      Settings.token,
      "",
    );
  }

  Future validateAndSetToken(
    String? newToken,
  ) async {
    if (_token == newToken) {
      return;
    }

    if (newToken == null) {
      await clearToken();
      notifyListeners();
      return;
    }

    _api.options.headers[Settings.token] = newToken;

    try {
      isLoading = true;
      notifyListeners();

      var response = await _api.get(
        ApiUrl.photo.path,
      );

      if (response.statusCode != HttpStatus.ok) {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
        );
      }

      isLoading = false;
      _token = newToken;
      notifyListeners();
    } catch (_) {
      isLoading = false;
      await clearToken();
      notifyListeners();
      rethrow;
    }
  }

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
        ApiUrl.signIn.path,
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

      _token = response.data["data"]["token"];
      prefs.setString(
        Settings.token,
        _token!,
      );

      notifyListeners();
    } catch (_) {
      isLoading = false;
      notifyListeners();
      rethrow;
    }
  }
}
