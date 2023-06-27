import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:punch_clock_photo_grapher_mobile/constants/settings.dart';

class CustomDio extends DioForNative {
  CustomDio() {
    options.baseUrl = Settings.apiUrl;
    options.contentType = Headers.formUrlEncodedContentType;
  }
}
