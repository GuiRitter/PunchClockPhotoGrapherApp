import 'package:punch_clock_photo_grapher_app/utils/logger.dart';

class SignInModel implements Loggable {
  late String userId;
  late String password;

  SignInModel({
    required this.userId,
    required this.password,
  });

  SignInModel.fromJson(
    Map<String, dynamic> json,
  ) {
    userId = json["login"];
    password = json["password"];
  }

  @override
  Map<String, dynamic> asLog() => <String, dynamic>{
        "userId": userId,
        "password": hideSecret(password),
      };

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["login"] = userId;
    data["password"] = password;
    return data;
  }
}
