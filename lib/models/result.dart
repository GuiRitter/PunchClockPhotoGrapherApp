import 'dart:io';

import 'package:dio/dio.dart';
import 'package:punch_clock_photo_grapher_app/common/result_status.enum.dart';
import 'package:punch_clock_photo_grapher_app/main.dart';
import 'package:punch_clock_photo_grapher_app/models/loggable.model.dart';

class Result<DataType> implements LoggableModel {
  final DataType? data;
  final ResultStatus status;
  final String? message;

  factory Result.fromException({
    required dynamic exception,
  }) {
    return Result._(
      status: getFromException(
        exception: exception,
      ),
      message: treatException(
        exception: exception,
      ),
    );
  }

  factory Result.fromResponse({
    required Response response,
  }) {
    return Result._(
      status: getFromHttpStatus(
        httpStatus: response.statusCode,
      ),
      message: treatDioResponse(
        response: response,
      ),
      data: response.data,
    );
  }

  Result.success({
    this.data,
    this.message,
  }) : status = ResultStatus.success;

  Result.warning({
    this.message,
    this.data,
  }) : status = ResultStatus.warning;

  Result._({
    this.data,
    required this.status,
    this.message,
  });

  @override
  Map<String, dynamic> asLog() => <String, dynamic>{
        "resultStatus": status.name,
        "message": message,
      };

  bool hasMessageNotIn({
    required ResultStatus status,
  }) =>
      (this.status != status);

  Result<NewDataType> withData<NewDataType>({
    required NewDataType Function(dynamic) handler,
  }) =>
      Result._(
        status: status,
        message: message,
        data: handler(
          data,
        ),
      );

  Result withoutData() => Result._(
        status: status,
        message: message,
        data: null,
      );

  static ResultStatus getFromException({
    required DioException exception,
  }) =>
      (exception.type == DioExceptionType.cancel)
          ? ResultStatus.cancelled
          : ResultStatus.error;

  static ResultStatus getFromHttpStatus({
    required int? httpStatus,
  }) {
    final statusCodeClass = httpStatus.toString()[0];
    return (httpStatus == HttpStatus.unauthorized)
        ? ResultStatus.unauthorized
        : (statusCodeClass == "2")
            ? ResultStatus.success
            : (statusCodeClass == "4")
                ? ResultStatus.warning
                // 3 or 5 or else
                : ResultStatus.error;
  }
}
