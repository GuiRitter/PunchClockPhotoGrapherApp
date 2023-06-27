import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:punch_clock_photo_grapher_mobile_bloc/blocs/date_time.bloc.dart';
import 'package:punch_clock_photo_grapher_mobile_bloc/constants/api_url.dart';
import 'package:punch_clock_photo_grapher_mobile_bloc/constants/result_status.dart';
import 'package:punch_clock_photo_grapher_mobile_bloc/constants/settings.dart';
import 'package:punch_clock_photo_grapher_mobile_bloc/main.dart';
import 'package:punch_clock_photo_grapher_mobile_bloc/models/date_time_constants.dart';
import 'package:punch_clock_photo_grapher_mobile_bloc/models/result.dart';
import 'package:punch_clock_photo_grapher_mobile_bloc/models/sign_in.model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserBloc extends ChangeNotifier {
  String? _token;
  bool isLoading = false;
  String? _photoPath;

  final _api = Settings.api;

  String? get photoPath => _photoPath;
  set photoPath(
    String? newPhotoPath,
  ) {
    _photoPath = newPhotoPath;
    notifyListeners();
  }

  String? get token => _token;

  setUpSubmit({
    required BuildContext context,
    required String? photoPath,
  }) {
    final dateTimeBloc = Provider.of<DateTimeBloc>(
      context,
      listen: false,
    );

    dateTimeBloc.setDate(
      newDate: DateTimeConstants.nowDate,
      isNotify: false,
    );

    dateTimeBloc.setTime(
      newTime: DateTimeConstants.nowTime,
      isNotify: false,
    );

    _photoPath = photoPath;
    notifyListeners();
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

  Future<Result<String?>> validateAndSetToken({
    String? newToken,
    bool revalidate = false,
  }) async {
    if (revalidate) {
      newToken = _token;
    } else if (_token == newToken) {
      return Result(
        status: ResultStatus.success,
      );
    }

    if (newToken == null) {
      await _clearToken();
      notifyListeners();
      return Result(
        status: ResultStatus.success,
      );
    }

    _api.options.headers[Settings.token] = newToken;

    isLoading = true;
    notifyListeners();

    var response = await _validateToken();

    isLoading = false;

    if (response.status == ResultStatus.failure) {
      await _clearToken();
    } else {
      _token = newToken;
    }

    notifyListeners();

    return response;
  }

  _clearToken() async {
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

  Future<Result<String?>> _validateToken() async {
    try {
      final response = await _api.get(
        ApiUrl.photo.path,
      );

      return Result(
        status: ResultStatus.success,
        data: response.data.toString(),
      );
    } catch (exception) {
      return Result(
        status: ((exception is DioException) &&
                (exception.response?.statusCode == HttpStatus.unauthorized))
            ? ResultStatus.failure
            : ResultStatus.error,
        message: treatException(
          exception: exception,
        ),
      );
    }
  }
}
