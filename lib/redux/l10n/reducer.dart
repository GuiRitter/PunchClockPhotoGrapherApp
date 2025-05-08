import 'package:flutter_guiritter/redux/l10n/action.dart' show L10nAction;
import 'package:punch_clock_photo_grapher_app/common/common.import.dart'
    show AppLocalizations;
import 'package:punch_clock_photo_grapher_app/model/model.import.dart'
    show StateModel;
import 'package:redux/redux.dart' show TypedReducer, combineReducers;

final l10nCombinedReducer = combineReducers<StateModel>(
  [
    setL10nTypedReducer,
  ],
);

final setL10nTypedReducer =
    TypedReducer<StateModel, L10nAction<AppLocalizations>>(
  setL10nReducer,
).call;

StateModel setL10nReducer(
  StateModel stateModel,
  L10nAction<AppLocalizations> action,
) =>
    stateModel.copyWith(
      l10n: () => action.l10n,
      l10nGuiRitter: () => action.l10nGuiRitter,
    );
