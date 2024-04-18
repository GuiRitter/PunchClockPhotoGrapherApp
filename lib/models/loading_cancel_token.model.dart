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
}
