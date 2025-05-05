import 'package:punch_clock_photo_grapher_app/models/models.import.dart'
    show StateModel;
import 'package:punch_clock_photo_grapher_app/redux/navigation/action.dart'
    show NavigationAction;
import 'package:redux/redux.dart' show TypedReducer, combineReducers;

final goTypedReducer = TypedReducer<StateModel, NavigationAction>(
  goReducer,
).call;

final navigationCombinedReducer = combineReducers<StateModel>(
  [
    goTypedReducer,
  ],
);

StateModel goReducer(
  StateModel stateModel,
  NavigationAction action,
) =>
    stateModel.copyWith(
      state: () => action.state,
    );
