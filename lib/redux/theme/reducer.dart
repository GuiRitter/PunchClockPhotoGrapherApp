import 'package:flutter_guiritter/redux/theme/action.dart'
    as theme_action_gui_ritter;
import 'package:punch_clock_photo_grapher_app/model/model.import.dart'
    show StateModelWrapper;
import 'package:redux/redux.dart' show TypedReducer, combineReducers;

final setThemeTypedReducer =
    TypedReducer<Map<String, dynamic>, theme_action_gui_ritter.ThemeAction>(
  setThemeReducer,
).call;

final themeCombinedReducer = combineReducers<Map<String, dynamic>>(
  [
    setThemeTypedReducer,
  ],
);

Map<String, dynamic> setThemeReducer(
  Map<String, dynamic> stateModelMap,
  theme_action_gui_ritter.ThemeAction action,
) =>
    StateModelWrapper(
      storeStateMap: stateModelMap,
    ).copyWith(
      themeMode: () => action.themeMode,
    );
