import 'package:flutter/material.dart' show ThemeMode;
import 'package:flutter_guiritter/redux/theme.action.dart'
    as theme_action_gui_ritter;
import 'package:punch_clock_photo_grapher_app/models/models.import.dart'
    show StateModel;
import 'package:redux/redux.dart' show Store;
import 'package:redux_thunk/redux_thunk.dart' show ThunkAction;

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

class ThemeActionOld {
  final ThemeMode themeMode;

  const ThemeActionOld({
    required this.themeMode,
  });
}
