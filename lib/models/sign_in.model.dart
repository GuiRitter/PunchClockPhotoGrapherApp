import 'package:punch_clock_photo_grapher_app/models/loggable.model.dart';
import 'package:punch_clock_photo_grapher_app/models/state.model.dart';
import 'package:punch_clock_photo_grapher_app/utils/logger.dart';
import 'package:redux/redux.dart';

class SignInModel implements LoggableModel {
  final String? token;

  SignInModel({
    required this.token,
  });

  @override
  int get hashCode => Object.hash(
        token,
        token,
      );

  @override
  bool operator ==(
    Object other,
  ) {
    if (other is! SignInModel) {
      return false;
    }
    if ((token == null) != (other.token == null)) {
      return false;
    }
    return token == other.token;
  }

  @override
  Map<String, dynamic> asLog() => <String, dynamic>{
        "token": hideSecret(
          token,
        ),
      };

  static SignInModel select(
    Store<StateModel> store,
  ) =>
      SignInModel(
        token: store.state.token,
      );
}
