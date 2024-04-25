import 'package:flutter/material.dart';
import 'package:punch_clock_photo_grapher_app/models/loading_cancel_token.model.dart';
import 'package:punch_clock_photo_grapher_app/models/tabs.model.dart';
import 'package:redux/redux.dart';

class StateModel {
  final List<LoadingTagModel> loadingTagList;
  final ThemeMode themeMode;
  final String? token;

  StateModel({
    required this.loadingTagList,
    required this.themeMode,
    required this.token,
  });

  StateModel withLoadingTagList({
    required List<LoadingTagModel> newLoadingTagList,
  }) =>
      StateModel(
        loadingTagList: loadingTagList + newLoadingTagList,
        themeMode: themeMode,
        token: token,
      );

  StateModel withoutLoadingTagList({
    required List<String> idList,
  }) {
    final newLoadingTagList = List<LoadingTagModel>.from(loadingTagList);

    for (final id in idList) {
      final index = newLoadingTagList.indexWhere(
        (
          loadingTag,
        ) =>
            id == loadingTag.id,
      );

      // FIXME not finding the index above
      newLoadingTagList.removeAt(index);
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

  static List<LoadingTagModel> selectLoadingTagList(
    Store<StateModel> store,
  ) =>
      store.state.loadingTagList;

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
