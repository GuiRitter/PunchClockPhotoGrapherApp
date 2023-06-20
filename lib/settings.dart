import 'package:punch_clock_photo_grapher_mobile_bloc/services/custom_dio.dart';

class Settings {
  static String apiUrl =
      "https://guilherme-alan-ritter.net/punch_clock_photo_grapher/api/";

  static String apiSignInUrl = "user/sign_in";

  static String token = "token";

  static CustomDio api = CustomDio();
}
