import 'package:flutter_guiritter/redux/theme/action.dart'
    as theme_action_gui_ritter;
import 'package:punch_clock_photo_grapher_app/models/models.import.dart'
    show StateModel;
import 'package:redux/redux.dart' show TypedReducer, combineReducers;

final setThemeTypedReducer =
    TypedReducer<StateModel, theme_action_gui_ritter.ThemeAction>(
  setThemeReducer,
).call;

final themeCombinedReducer = combineReducers<StateModel>(
  [
    setThemeTypedReducer,
  ],
);

StateModel setThemeReducer(
  StateModel stateModel,
  theme_action_gui_ritter.ThemeAction action,
) =>
    stateModel.copyWith(
      themeMode: () => action.themeMode,
    );
