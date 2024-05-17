import "package:dio/browser.dart" show DioForBrowser;
import "package:dio/dio.dart"
    show CancelToken, Headers, Options, ProgressCallback;
import "package:punch_clock_photo_grapher_app/common/common.import.dart"
    show Settings;
import "package:punch_clock_photo_grapher_app/models/models.import.dart"
    show Result;
import "package:punch_clock_photo_grapher_app/services/dio/dio_for_any.interface.dart"
    show DioForAny;

DioForAny getDioForAny() => DioForAnyBrowser();

class DioForAnyBrowser extends DioForBrowser implements DioForAny {
  DioForAnyBrowser() {
    options.baseUrl = Settings.apiUrl;
    options.contentType = Headers.formUrlEncodedContentType;
    // options.contentType = Headers.jsonContentType;
    // options.headers.putIfAbsent(
    //   "Access-Control-Allow-Origin",
    //   () => "*",
    // );
  }

  @override
  Future<Result> httpDelete(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );

      return Result.fromResponse(
        response: response,
      );
    } catch (exception) {
      return Result.fromException(
        exception: exception,
      );
    }
  }

  @override
  Future<Result> httpGet(
    String path, {
    Map<String, dynamic>? queryParameters,
    Object? data,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await get(
        path,
        queryParameters: queryParameters,
        data: data,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );

      return Result.fromResponse(
        response: response,
      );
    } catch (exception) {
      return Result.fromException(
        exception: exception,
      );
    }
  }

  @override
  Future<Result> httpPatch(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      return Result.fromResponse(
        response: response,
      );
    } catch (exception) {
      return Result.fromException(
        exception: exception,
      );
    }
  }

  @override
  Future<Result> httpPost(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      return Result.fromResponse(
        response: response,
      );
    } catch (exception) {
      return Result.fromException(
        exception: exception,
      );
    }
  }

  @override
  Future<Result> httpRequest(
    String method,
    String path, {
    Map<String, dynamic>? queryParameters,
    Object? data,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    if (options == null) {
      options = Options(
        method: method,
      );
    } else {
      options.method = method;
    }

    try {
      final response = await request(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      return Result.fromResponse(
        response: response,
      );
    } catch (exception) {
      return Result.fromException(
        exception: exception,
      );
    }
  }
}
