import 'package:dio/dio.dart' show CancelToken;
import 'package:punch_clock_photo_grapher_app/models/models.import.dart'
    show LoggableModel;

class LoadingTagModel implements LoggableModel {
  final String id;

  final CancelToken cancelToken;

  final String userFriendlyName;

  LoadingTagModel({
    required this.userFriendlyName,
    required this.id,
    required this.cancelToken,
  });

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(
    Object other,
  ) {
    if (other is! LoadingTagModel) {
      return false;
    }
    return idEquals(id)(other);
  }

  @override
  Map<String, dynamic> asLog() => <String, dynamic>{
        'id': id,
        'userFriendlyName': userFriendlyName,
        'cancelToken': cancelToken.toString(),
      };

  static bool Function(
    LoadingTagModel,
  ) idEquals(
    String id,
  ) =>
      (
        LoadingTagModel element,
      ) =>
          element.id == id;
}
