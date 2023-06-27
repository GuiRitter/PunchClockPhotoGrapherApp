import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:punch_clock_photo_grapher_mobile/blocs/date_time.bloc.dart';
import 'package:punch_clock_photo_grapher_mobile/constants/api_url.dart';
import 'package:punch_clock_photo_grapher_mobile/constants/result_status.dart';
import 'package:punch_clock_photo_grapher_mobile/constants/settings.dart';
import 'package:punch_clock_photo_grapher_mobile/main.dart';
import 'package:punch_clock_photo_grapher_mobile/models/date_time_constants.dart';
import 'package:punch_clock_photo_grapher_mobile/models/post_photo.dart';
import 'package:punch_clock_photo_grapher_mobile/models/result.dart';
import 'package:punch_clock_photo_grapher_mobile/models/sign_in.model.dart';
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
            Settings.data,
          )) ||
          ((response.data as Map)[Settings.data] is! Map) ||
          (!((response.data as Map)[Settings.data] as Map).containsKey(
            Settings.token,
          ))) {
        throw response;
      }

      _token = response.data[Settings.data][Settings.token];
      prefs.setString(
        Settings.token,
        _token!,
      );
      _api.options.headers[Settings.token] = _token;

      notifyListeners();
    } catch (_) {
      isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<Result<void>> submitPhoto({
    required BuildContext context,
    required Uint8List imageBytes,
  }) async {
    final base64Image = base64Encode(
      imageBytes,
    );

    final dateTimeBloc = Provider.of<DateTimeBloc>(
      context,
      listen: false,
    );

    var dateTime = getISO8601(
      date: dateTimeBloc.date,
      time: dateTimeBloc.time,
    );

    isLoading = true;
    notifyListeners();

    var response = await _submitPhoto(
      dateTime: dateTime,
      dataURI: Settings.pngDataURI(
        base64Image,
      ),
    );

    isLoading = false;

    if (response.status == ResultStatus.unauthorized) {
      await _clearToken();
    }

    notifyListeners();

    return response;
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

    if (response.status == ResultStatus.unauthorized) {
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

  Future<Result<String?>> _submitPhoto({
    required String dateTime,
    required String dataURI,
  }) async {
    try {
      final response = await _api.post(
        ApiUrl.photo.path,
        data: PostPhoto(
          dateTime: dateTime,
          dataURI: dataURI,
        ).toJson(),
      );

      return Result(
        status: ResultStatus.success,
        data: response.data.toString(),
      );
    } catch (exception) {
      return Result(
        status: ((exception is DioException) &&
                (exception.response?.statusCode == HttpStatus.unauthorized))
            ? ResultStatus.unauthorized
            : ResultStatus.error,
        message: treatException(
          exception: exception,
        ),
      );
    }
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
            ? ResultStatus.unauthorized
            : ResultStatus.error,
        message: treatException(
          exception: exception,
        ),
      );
    }
  }
}
