import 'package:punch_clock_photo_grapher_app/models/models.import.dart'
    show BaseRequestModel;
import 'package:punch_clock_photo_grapher_app/utils/utils.import.dart'
    show hideSecret;

class SignInRequestModel implements BaseRequestModel {
  late String userId;
  late String password;

  SignInRequestModel({
    required this.userId,
    required this.password,
  });

  SignInRequestModel.fromJson(
    Map<String, dynamic> json,
  )   : userId = json["login"],
        password = json["password"];

  @override
  Map<String, dynamic> asLog() => <String, dynamic>{
        "userId": userId,
        "password": hideSecret(
          password,
        ),
      };

  @override
  Map<String, dynamic> toJson() => {
        "login": userId,
        "password": password,
      };
}
