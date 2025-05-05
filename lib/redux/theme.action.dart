import 'package:flutter/material.dart' show ThemeMode;
import 'package:flutter_guiritter/redux/theme.action.dart'
    as theme_action_gui_ritter;
import 'package:punch_clock_photo_grapher_app/models/models.import.dart'
    show StateModel;
import 'package:redux/redux.dart' show Store, TypedReducer;
import 'package:redux_thunk/redux_thunk.dart' show ThunkAction;

final setThemeTypedReducer =
    TypedReducer<StateModel, theme_action_gui_ritter.ThemeAction>(
  setThemeReducer,
).call;

ThunkAction<StateModel> setTheme({
  required ThemeMode themeMode,
}) =>
    (
      Store<StateModel> store,
    ) async =>
        store.dispatch(
          theme_action_gui_ritter.ThemeAction(
            themeMode: themeMode,
          ),
        );

StateModel setThemeReducer(
  StateModel stateModel,
  theme_action_gui_ritter.ThemeAction action,
) =>
    stateModel.copyWith(
      themeMode: () => action.themeMode,
    );

class ThemeActionOld {
  final ThemeMode themeMode;

  const ThemeActionOld({
    required this.themeMode,
  });
}
