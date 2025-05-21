import 'package:flutter_guiritter/util/util.import.dart' show logger;
import 'package:punch_clock_photo_grapher_app/common/common.import.dart'
    show StateEnum;
import 'package:redux/redux.dart' show Store;
import 'package:redux_thunk/redux_thunk.dart' show ThunkAction;

final _log = logger('navigation.action');

ThunkAction<Map<String, dynamic>> go({
  required StateEnum state,
}) =>
    (
      Store<Map<String, dynamic>> store,
    ) async {
      _log('navigate').print();

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
