import 'package:flutter/material.dart';
import 'package:punch_clock_photo_grapher_app/models/state.model.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

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
