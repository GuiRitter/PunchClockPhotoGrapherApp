import 'package:flutter/material.dart';
import 'package:punch_clock_photo_grapher_mobile/services/custom_dio.dart';

class Settings {
  static String apiUrl =
      "https://guilherme-alan-ritter.net/punch_clock_photo_grapher/api/";

  static String token = "token";

  static CustomDio api = CustomDio();

  static final GlobalKey<ScaffoldMessengerState> snackState =
      GlobalKey<ScaffoldMessengerState>();

  static String pngDataURI(
    String base64Data,
  ) =>
      "data:image/png;base64,$base64Data";
}
