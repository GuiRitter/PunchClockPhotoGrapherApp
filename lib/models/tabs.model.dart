import 'package:punch_clock_photo_grapher_app/common/state.enum.dart';
import 'package:punch_clock_photo_grapher_app/models/loggable.model.dart';
import 'package:punch_clock_photo_grapher_app/models/state.model.dart';
import 'package:redux/redux.dart';

class TabsModel implements LoggableModel {
  final bool isSignedIn;
  final bool isLoading;
  final StateEnum state;

  TabsModel({
    required this.isSignedIn,
    required this.isLoading,
    required this.state,
  });

  @override
  int get hashCode => Object.hash(
        isSignedIn,
        isLoading,
        state,
      );

  @override
  bool operator ==(
    Object other,
  ) {
    if (other is! TabsModel) {
      return false;
    }
    return (isSignedIn == other.isSignedIn) &&
        (isLoading == other.isLoading) &&
        (state == other.state);
  }

  @override
  Map<String, dynamic> asLog() => <String, dynamic>{
        "isSignedIn": isSignedIn,
        "isLoading": isLoading,
        "state": state.name,
      };

  static TabsModel select(
    Store<StateModel> store,
  ) =>
      TabsModel(
        isSignedIn: StateModel.selectIsSignedIn(
          store,
        ),
        isLoading: StateModel.selectIsLoading(
          store,
        ),
        state: StateModel.selectState(
          store,
        ),
      );
}
