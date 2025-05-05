import 'package:dio/dio.dart' show CancelToken;
import 'package:punch_clock_photo_grapher_app/models/models.import.dart'
    show LoadingTagModel;
import 'package:punch_clock_photo_grapher_app/utils/utils.import.dart'
    show DateTimeNullableExtension;

LoadingTagModel buildTag({
  required String userFriendlyName,
  required CancelToken cancelToken,
}) =>
    LoadingTagModel(
      id: DateTime.now().getISO8601()!,
      userFriendlyName: userFriendlyName,
      cancelToken: cancelToken,
    );
