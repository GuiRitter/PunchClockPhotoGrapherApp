import 'package:dio/dio.dart';

class LoadingTagModel {
  final String id;

  final CancelToken cancelToken;

  final String userFriendlyName;

  LoadingTagModel({
    required this.userFriendlyName,
    required this.id,
    required this.cancelToken,
  });

  static idEquals(
    String id,
  ) =>
      (
        LoadingTagModel element,
      ) =>
          element.id == id;
}
