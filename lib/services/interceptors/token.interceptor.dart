import 'dart:io' show HttpStatus;

import 'package:dio/dio.dart'
    show DioException, ErrorInterceptorHandler, InterceptorsWrapper;
import 'package:punch_clock_photo_grapher_app/common/common.import.dart'
    show navigatorState;
import 'package:punch_clock_photo_grapher_app/redux/main.reducer.dart'
    show getDispatch;
import 'package:punch_clock_photo_grapher_app/redux/user.action.dart'
    as user_action;
import 'package:punch_clock_photo_grapher_app/utils/utils.import.dart'
    show logger;

final _log = logger('TokenInterceptor');

class TokenInterceptor extends InterceptorsWrapper {
  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    _log('onError').asString('err', err).print();

    final context = navigatorState.currentContext!;

    final dispatch = getDispatch(
      context: context,
    );

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
  }
}
