import 'package:flutter_guiritter/model/_import.dart' show LoggableModel;
import 'package:punch_clock_photo_grapher_app/common/_import.dart'
    show StateEnum;
import 'package:punch_clock_photo_grapher_app/model/_import.dart'
    show StateModelWrapper;
import 'package:redux/redux.dart' show Store;

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
        'isSignedIn': isSignedIn,
        'isLoading': isLoading,
        'state': state.name,
      };

  static TabsModel select(
    Store<Map<String, dynamic>> store,
  ) =>
      TabsModel(
        isSignedIn: StateModelWrapper.selectIsSignedIn(
          store,
        ),
        isLoading: StateModelWrapper.selectIsLoading(
          store,
        ),
        state: StateModelWrapper.selectState(
          store,
        ),
      );
}
