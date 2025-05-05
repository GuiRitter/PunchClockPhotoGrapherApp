import 'package:punch_clock_photo_grapher_app/models/models.import.dart'
    show StateModel;
import 'package:punch_clock_photo_grapher_app/redux/user/action.dart'
    show AuthenticationAction;
import 'package:redux/redux.dart' show TypedReducer, combineReducers;

final setTokenTypedReducer = TypedReducer<StateModel, AuthenticationAction>(
  setTokenReducer,
).call;

final userCombinedReducer = combineReducers<StateModel>(
  [
    setTokenTypedReducer,
  ],
);

StateModel setTokenReducer(
  StateModel stateModel,
  AuthenticationAction action,
) =>
    stateModel.copyWith(
      token: () => action.token,
    );
