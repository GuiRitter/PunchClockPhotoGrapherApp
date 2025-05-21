import 'package:flutter_guiritter/redux/l10n/action.dart' show L10nAction;
import 'package:punch_clock_photo_grapher_app/common/common.import.dart'
    show AppLocalizations;
import 'package:punch_clock_photo_grapher_app/model/model.import.dart'
    show StateModelWrapper;
import 'package:redux/redux.dart' show TypedReducer, combineReducers;

final l10nCombinedReducer = combineReducers<Map<String, dynamic>>(
  [
    setL10nTypedReducer,
  ],
);

final setL10nTypedReducer =
    TypedReducer<Map<String, dynamic>, L10nAction<AppLocalizations>>(
  setL10nReducer,
).call;

Map<String, dynamic> setL10nReducer(
  Map<String, dynamic> stateModelMap,
  L10nAction<AppLocalizations> action,
) =>
    StateModelWrapper(
      storeStateMap: stateModelMap,
    ).copyWith(
      l10n: () => action.l10n,
      l10nGuiRitter: () => action.l10nGuiRitter,
    );
