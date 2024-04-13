import 'package:flutter/material.dart';
import 'package:punch_clock_photo_grapher_app/models/tabs.model.dart';
import 'package:redux/redux.dart';

class StateModel {
  final List<String> loadingTagList;
  final ThemeMode themeMode;
  final String? token;

  StateModel({
    required this.loadingTagList,
    required this.themeMode,
    required this.token,
  });

  StateModel withLoadingTagList({
    required List<String> newLoadingTagList,
  }) =>
      StateModel(
        loadingTagList: loadingTagList + newLoadingTagList,
        themeMode: themeMode,
        token: token,
      );

  StateModel withoutLoadingTagList({
    required List<String> oldLoadingTagList,
  }) {
    final newLoadingTagList = List<String>.from(loadingTagList);

    for (final oldLoadingTag in oldLoadingTagList) {
      final loadingTagIndex = newLoadingTagList.indexWhere(
        (
          newLoadingTag,
        ) =>
            oldLoadingTag == newLoadingTag,
      );

      newLoadingTagList.removeAt(loadingTagIndex);
    }

    return StateModel(
      loadingTagList: newLoadingTagList,
      themeMode: themeMode,
      token: token,
    );
  }

  StateModel withThemeMode({
    required ThemeMode themeMode,
  }) =>
      StateModel(
        loadingTagList: loadingTagList,
        themeMode: themeMode,
        token: token,
      );

  StateModel withToken({
    required String? token,
  }) =>
      StateModel(
        loadingTagList: loadingTagList,
        themeMode: themeMode,
        token: token,
      );

  static bool selectIsLoading(
    Store<StateModel> store,
  ) =>
      store.state.loadingTagList.isNotEmpty;

  static bool selectIsSignedIn(
    Store<StateModel> store,
  ) =>
      store.state.token?.isNotEmpty ?? false;

  static TabsModel selectTabsModel(
    Store<StateModel> store,
  ) =>
      TabsModel(
        isSignedIn: selectIsSignedIn(
          store,
        ),
        isLoading: selectIsLoading(
          store,
        ),
      );

  static String selectTokenNotNull(
    Store<StateModel> store,
  ) =>
      store.state.token ?? "";
}
