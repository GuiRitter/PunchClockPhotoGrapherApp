import 'package:flutter_guiritter/model/model.import.dart' show LoggableModel;
import 'package:punch_clock_photo_grapher_app/models/models.import.dart'
    show StateModel;
import 'package:redux/redux.dart' show Store;

class InitModel implements LoggableModel {
  final bool isL10nLoaded;

  InitModel({
    required this.isL10nLoaded,
  });

  @override
  int get hashCode => isL10nLoaded.hashCode;

  @override
  bool operator ==(
    Object other,
  ) {
    if (other is! InitModel) {
      return false;
    }
    return (isL10nLoaded == other.isL10nLoaded);
  }

  @override
  Map<String, dynamic> asLog() => <String, dynamic>{
        'isL10nLoaded': isL10nLoaded,
      };

  static InitModel select(
    Store<StateModel> store,
  ) =>
      InitModel(
        isL10nLoaded: StateModel.selectIsL10nLoaded(
          store,
        ),
      );
}
