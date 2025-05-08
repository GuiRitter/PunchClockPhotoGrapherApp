import 'package:punch_clock_photo_grapher_app/model/model.import.dart'
    show StateModel;
import 'package:punch_clock_photo_grapher_app/redux/l10n/action.dart';
import 'package:redux/redux.dart' show TypedReducer, combineReducers;

final l10nCombinedReducer = combineReducers<StateModel>(
  [
    setL10nTypedReducer,
  ],
);

final setL10nTypedReducer = TypedReducer<StateModel, L10nAction>(
  setL10nReducer,
).call;

StateModel setL10nReducer(
  StateModel stateModel,
  L10nAction action,
) =>
    stateModel.copyWith(
      l10n: () => action.l10n,
      l10nGuiRitter: () => action.l10nGuiRitter,
    );
