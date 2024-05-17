import 'package:punch_clock_photo_grapher_app/common/common.import.dart'
    show StateEnum;
import 'package:punch_clock_photo_grapher_app/models/models.import.dart'
    show StateModel;
import 'package:punch_clock_photo_grapher_app/utils/utils.import.dart'
    show logger;
import 'package:redux/redux.dart' show Store;
import 'package:redux_thunk/redux_thunk.dart' show ThunkAction;

final _log = logger('navigation.action');

ThunkAction<StateModel> go({
  required StateEnum state,
}) =>
    (
      Store<StateModel> store,
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
