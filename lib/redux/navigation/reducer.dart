import 'package:punch_clock_photo_grapher_app/model/_import.dart'
    show StateModelWrapper;
import 'package:punch_clock_photo_grapher_app/redux/navigation/action.dart'
    show NavigationAction;
import 'package:redux/redux.dart' show TypedReducer, combineReducers;

final goTypedReducer = TypedReducer<Map<String, dynamic>, NavigationAction>(
  goReducer,
).call;

final navigationCombinedReducer = combineReducers<Map<String, dynamic>>(
  [
    goTypedReducer,
  ],
);

Map<String, dynamic> goReducer(
  Map<String, dynamic> stateModelMap,
  NavigationAction action,
) =>
    StateModelWrapper(
      storeStateMap: stateModelMap,
    ).copyWith(
      state: () => action.state,
    );
