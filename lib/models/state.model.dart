import 'package:flutter/material.dart';
import 'package:punch_clock_photo_grapher_app/models/list.model.dart';
import 'package:punch_clock_photo_grapher_app/models/loading_tag.model.dart';
import 'package:redux/redux.dart';

class StateModel {
  final List<LoadingTagModel> loadingTagList;
  final ThemeMode themeMode;
  final String? token;
  final ListModel? list;

  StateModel({
    required this.loadingTagList,
    required this.themeMode,
    required this.token,
    required list,
  }) : list = (token != null) ? list : null;

  StateModel withData({
    required ListModel? list,
  }) =>
      StateModel(
        loadingTagList: loadingTagList,
        themeMode: themeMode,
        token: token,
        list: list,
      );

  StateModel withLoadingTagList({
    required List<LoadingTagModel> newLoadingTagList,
  }) =>
      StateModel(
        loadingTagList: loadingTagList + newLoadingTagList,
        themeMode: themeMode,
        token: token,
        list: list,
      );

  StateModel withoutLoadingTagList({
    required List<String> idList,
  }) {
    final newLoadingTagList = List<LoadingTagModel>.from(loadingTagList);

    for (final id in idList) {
      final index = newLoadingTagList.indexWhere(
        LoadingTagModel.idEquals(
          id,
        ),
      );

      newLoadingTagList.removeAt(index);
    }

    return StateModel(
      loadingTagList: newLoadingTagList,
      themeMode: themeMode,
      token: token,
      list: list,
    );
  }

  StateModel withThemeMode({
    required ThemeMode themeMode,
  }) =>
      StateModel(
        loadingTagList: loadingTagList,
        themeMode: themeMode,
        token: token,
        list: list,
      );

  StateModel withToken({
    required String? token,
  }) =>
      StateModel(
        loadingTagList: loadingTagList,
        themeMode: themeMode,
        token: (token == "") ? null : token,
        list: (token?.isNotEmpty ?? false) ? list : null,
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
}
