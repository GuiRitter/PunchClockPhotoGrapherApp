import 'package:dio/dio.dart';
import 'package:punch_clock_photo_grapher_app/common/http_method.dart';
import 'package:punch_clock_photo_grapher_app/common/result_status.enum.dart';
import 'package:punch_clock_photo_grapher_app/common/settings.dart' as settings;
import 'package:punch_clock_photo_grapher_app/common/settings.dart'
    show l10n, tokenKey;
import 'package:punch_clock_photo_grapher_app/main.dart';
import 'package:punch_clock_photo_grapher_app/models/base_request.model.dart';
import 'package:punch_clock_photo_grapher_app/models/loading_tag.model.dart';
import 'package:punch_clock_photo_grapher_app/models/result.dart';
import 'package:punch_clock_photo_grapher_app/models/state.model.dart';
import 'package:punch_clock_photo_grapher_app/redux/loading.action.dart';
import 'package:punch_clock_photo_grapher_app/redux/user.action.dart';
import 'package:punch_clock_photo_grapher_app/utils/logger.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

final _api = settings.api;

final _log = logger("dio.action.dart");

void clearToken() {
  _log("clearToken").print();

  _api.options.headers.remove(
    settings.tokenKey,
  );
}

ThunkAction<StateModel> get({
  required String url,
  Map<String, dynamic>? queryParameters,
  Map<String, dynamic> config = const <String, dynamic>{},
  required String userFriendlyName,
  required Future<void> Function({
    required Result result,
  }) thenFunction,
  Future<void> Function({
    required Result result,
  })? catchFunction,
  Future<void> Function()? finallyFunction,
}) =>
    (
      Store<StateModel> store,
    ) async {
      _log("get")
          .raw("url", url)
          .raw("queryParameters", queryParameters)
          .raw("config", config)
          .raw("userFriendlyName", userFriendlyName)
          .exists("then", thenFunction)
          .exists("catch", catchFunction)
          .exists("finally", finallyFunction)
          .print();

      store.dispatch(
        _requestAndToggleLoading(
          method: HTTPMethod.get,
          url: url,
          queryParameters: queryParameters,
          data: null,
          config: config,
          userFriendlyName: userFriendlyName,
          thenFunction: thenFunction,
          catchFunction: catchFunction,
          finallyFunction: finallyFunction,
        ),
      );
    };

ThunkAction<StateModel> post({
  required String url,
  Map<String, dynamic>? queryParameters,
  BaseRequestModel? data,
  Map<String, dynamic> config = const <String, dynamic>{},
  required String userFriendlyName,
  required Future<void> Function({
    required Result result,
  }) thenFunction,
  Future<void> Function({
    required Result result,
  })? catchFunction,
  Future<void> Function()? finallyFunction,
}) =>
    (
      Store<StateModel> store,
    ) async {
      _log("post")
          .raw("url", url)
          .raw("queryParameters", queryParameters)
          .map("data", data)
          .raw("config", config)
          .raw("userFriendlyName", userFriendlyName)
          .exists("then", thenFunction)
          .exists("catch", catchFunction)
          .exists("finally", finallyFunction)
          .print();

      store.dispatch(
        _requestAndToggleLoading(
          method: HTTPMethod.post,
          url: url,
          queryParameters: queryParameters,
          data: data,
          config: config,
          userFriendlyName: userFriendlyName,
          thenFunction: thenFunction,
          catchFunction: catchFunction,
          finallyFunction: finallyFunction,
        ),
      );
    };

void setToken({
  required String token,
}) {
  _log("setToken").secret("token", token).print();

  _api.options.headers[settings.tokenKey] = token;
}

Future<void> showSnackBarFromResult({
  required Result result,
}) async {
  _log("showSnackBarFromResult").map("result", result).print();

  showSnackBar(
    message: result.message,
  );
}

void toggleToken({
  required String? token,
}) {
  _log("toggleToken").secret("token", token).print();

  if (token == null) {
    clearToken();
  } else {
    setToken(
      token: token,
    );
  }
}

Future<Result<dynamic>> _getResult({
  required HTTPMethod method,
  required String url,
  Map<String, dynamic>? queryParameters,
  BaseRequestModel? data,
  required CancelToken cancelToken,
}) async {
  _log("_getResult")
      .enum_("method", method)
      .raw("url", url)
      .raw("queryParameters", queryParameters)
      .map("data", data)
      .secret("token", tokenKey)
      .asString("cancelToken", cancelToken)
      .print();

  final request = {
        HTTPMethod.get: () => _api.httpGet(
              url,
              queryParameters: queryParameters,
              data: data?.toJson(),
              cancelToken: cancelToken,
            ),
        HTTPMethod.post: () => _api.httpPost(
              url,
              queryParameters: queryParameters,
              data: data?.toJson(),
              cancelToken: cancelToken,
            ),
      }[method] ??
      () => _api.httpRequest(
            method.name,
            url,
            queryParameters: queryParameters,
            data: data?.toJson(),
            cancelToken: cancelToken,
          );

  return await request();
}

ThunkAction<StateModel> _requestAndToggleLoading({
  required HTTPMethod method,
  required String url,
  Map<String, dynamic>? queryParameters,
  BaseRequestModel? data,
  Map<String, dynamic> config = const <String, dynamic>{},
  required String userFriendlyName,
  required Future<void> Function({
    required Result result,
  }) thenFunction,
  Future<void> Function({
    required Result result,
  })? catchFunction,
  Future<void> Function()? finallyFunction,
}) =>
    (
      Store<StateModel> store,
    ) async {
      _log("_requestAndToggleLoading")
          .raw("url", url)
          .raw("config", config)
          .exists("then", thenFunction)
          .exists("catch", catchFunction)
          .exists("finally", finallyFunction)
          .print();

      final loadingTag = buildLoadingTag(
        userFriendlyName: userFriendlyName,
        cancelToken: CancelToken(),
      );

      store.dispatch(
        addLoading(
          list: [
            loadingTag,
          ],
        ),
      );

      final result = await _getResult(
        method: method,
        url: url,
        data: data,
        queryParameters: queryParameters,
        cancelToken: loadingTag.cancelToken,
      );

      store.dispatch(
        _treatResult(
          result: result,
          thenFunction: thenFunction,
          catchFunction: catchFunction,
          finallyFunction: finallyFunction,
          loadingTag: loadingTag,
        ),
      );
    };

ThunkAction<StateModel> _treatResult({
  required Result result,
  required Future<void> Function({
    required Result result,
  }) thenFunction,
  Future<void> Function({
    required Result result,
  })? catchFunction,
  Future<void> Function()? finallyFunction,
  required LoadingTagModel loadingTag,
}) =>
    (
      Store<StateModel> store,
    ) async {
      _log("_treatResult")
          .map("result", result)
          .exists("then", thenFunction)
          .exists("catch", catchFunction)
          .exists("finally", finallyFunction)
          .map("loadingTag", loadingTag)
          .print();

      if (result.status == ResultStatus.success) {
        await thenFunction(
          result: result,
        );
      } else {
        if (result.status == ResultStatus.unauthorized) {
          store.dispatch(
            signOut(),
          );
          showSnackBar(
            message: result.message,
          );
        } else if (result.status == ResultStatus.cancelled) {
          // do nothing
        } else if (result.message == null) {
          showSnackBar(
            message: l10n.unexpectedError,
          );
        } else {
          showSnackBar(
            message: result.message,
          );
        }

        if (catchFunction != null) {
          await catchFunction(
            result: result,
          );
        }
      }

      if (finallyFunction != null) {
        await finallyFunction();
      }

      store.dispatch(
        removeLoading(
          idList: [
            loadingTag.id,
          ],
        ),
      );
    };
