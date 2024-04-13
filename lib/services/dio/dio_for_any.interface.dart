import 'package:dio/dio.dart';
import 'package:punch_clock_photo_grapher_app/models/result.dart';

import 'dio_for_any.stub.dart'
    // ignore: uri_does_not_exist
    if (dart.library.io) 'package:punch_clock_photo_grapher_app/services/dio/dio_for_any.native.dart'
    // ignore: uri_does_not_exist
    if (dart.library.html) 'package:punch_clock_photo_grapher_app/services/dio/dio_for_any.browser.dart';

/// https://stackoverflow.com/questions/58710226/how-to-import-platform-specific-dependency-in-flutter-dart-combine-web-with-an/58713064#58713064
abstract class DioForAny {
  late BaseOptions options;

  /// factory constructor to return the correct implementation.
  factory DioForAny() => getDioForAny();

  Future<Result> deleteResult(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  });

  Future<Result> getResult(
    String path, {
    Map<String, dynamic>? queryParameters,
    Object? data,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  });

  Future<Result> patchResult(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  });

  Future<Result> postResult(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  });
}
