import 'package:punch_clock_photo_grapher_mobile_bloc/constants/result_status.dart';

class Result<DataType> {
  final DataType? data;
  final ResultStatus status;
  final String? message;

  Result({
    this.data,
    required this.status,
    this.message,
  });
}
