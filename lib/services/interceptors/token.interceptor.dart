import 'dart:io' show HttpStatus;

import 'package:dio/dio.dart'
    show DioException, ErrorInterceptorHandler, InterceptorsWrapper;
import 'package:punch_clock_photo_grapher_app/redux/main.reducer.dart'
    show dispatch;
import 'package:punch_clock_photo_grapher_app/redux/user.redux.dart'
    as user_action;
import 'package:punch_clock_photo_grapher_app/utils/utils.import.dart'
    show logger;

final _log = logger('TokenInterceptor');

InterceptorsWrapper buildTokenInterceptor() => InterceptorsWrapper(
      onError: (
        DioException err,
        ErrorInterceptorHandler handler,
      ) async {
        _log('onError').asString('err', err).print();

        if (err.response?.statusCode == HttpStatus.unauthorized) {
          await dispatch(
            user_action.signOut(),
          );
        }

        if (err.response != null) {
          handler.resolve(
            err.response!,
          );
        } else {
          handler.next(
            err,
          );
        }
      },
    );
