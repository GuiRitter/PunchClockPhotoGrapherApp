import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:punch_clock_photo_grapher_app/common/settings.dart';
import 'package:punch_clock_photo_grapher_app/redux/main.reducer.dart';
import 'package:punch_clock_photo_grapher_app/redux/user.action.dart';
import 'package:punch_clock_photo_grapher_app/utils/logger.dart';

final _log = logger("TokenInterceptor");

class TokenInterceptor extends InterceptorsWrapper {
  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    _log("onError").asString("err", err).print();

    final context = navigatorState.currentContext!;

    final dispatch = getDispatch(
      context: context,
    );

    final l10n = AppLocalizations.of(
      context,
    )!;

    if (err.response?.statusCode == HttpStatus.unauthorized) {
      await dispatch(
        signOut(
          l10n: l10n,
        ),
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