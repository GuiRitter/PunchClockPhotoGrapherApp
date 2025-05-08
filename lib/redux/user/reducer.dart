import 'package:flutter_guiritter/redux/user/action.dart'
    show AuthenticationAction;
import 'package:punch_clock_photo_grapher_app/model/model.import.dart'
    show StateModel;
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
