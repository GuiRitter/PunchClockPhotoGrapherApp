import 'package:flutter/material.dart' show ThemeMode;
import 'package:punch_clock_photo_grapher_app/model/model.import.dart'
    show StateModelWrapper;
import 'package:redux/redux.dart' show Store;

ThemeMode themeSelector(
  Store<Map<String, dynamic>> store,
) =>
    StateModelWrapper(
      storeStateMap: store.state,
    ).themeMode;
