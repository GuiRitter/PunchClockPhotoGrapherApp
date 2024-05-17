import 'package:flutter/material.dart' show ThemeMode;
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
          ThemeAction(
            themeMode: themeMode,
          ),
        );

class ThemeAction {
  final ThemeMode themeMode;

  const ThemeAction({
    required this.themeMode,
  });
}
