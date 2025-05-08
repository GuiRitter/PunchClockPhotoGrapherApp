import 'package:flutter_guiritter/model/model.import.dart' show LoggableModel;
import 'package:flutter_guiritter/util/util.import.dart' show hideSecret;
import 'package:punch_clock_photo_grapher_app/model/model.import.dart'
    show StateModel;
import 'package:redux/redux.dart' show Store;

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
        'token': hideSecret(
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
