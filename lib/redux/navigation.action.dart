import 'package:punch_clock_photo_grapher_app/common/state.enum.dart';
import 'package:punch_clock_photo_grapher_app/models/state.model.dart';
import 'package:punch_clock_photo_grapher_app/utils/logger.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

final _log = logger("navigation.action");

ThunkAction<StateModel> navigate({
  required StateEnum state,
}) =>
    (
      Store<StateModel> store,
    ) async {
      _log("navigate").print();

      store.dispatch(
        NavigationAction(
          state: state,
        ),
      );
    };

class NavigationAction {
  final StateEnum state;

  const NavigationAction({
    required this.state,
  });
}
