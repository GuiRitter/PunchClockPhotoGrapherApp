import 'package:flutter/material.dart' show ThemeMode, TimeOfDay;
import 'package:punch_clock_photo_grapher_app/common/common.import.dart'
    show StateEnum;
import 'package:punch_clock_photo_grapher_app/models/models.import.dart'
    show LoadingTagModel, ListModel;
import 'package:redux/redux.dart' show Store;

class StateModel {
  final List<LoadingTagModel> loadingTagList;
  final ThemeMode themeMode;
  final String? token;
  final ListModel? list;
  final StateEnum state;
  final DateTime date;
  final TimeOfDay time;

  StateModel({
    required this.loadingTagList,
    required this.themeMode,
    required this.token,
    required list,
    required this.state,
    required this.date,
    required this.time,
  }) : list = (token != null) ? list : null;

  StateModel withData({
    required ListModel? list,
  }) =>
      StateModel(
        loadingTagList: loadingTagList,
        themeMode: themeMode,
        token: token,
        list: list,
        state: state,
        date: date,
        time: time,
      );

  StateModel withLoadingTagList({
    required List<LoadingTagModel> newLoadingTagList,
  }) =>
      StateModel(
        loadingTagList: loadingTagList + newLoadingTagList,
        themeMode: themeMode,
        token: token,
        list: list,
        state: state,
        date: date,
        time: time,
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
      state: state,
      date: date,
      time: time,
    );
  }

  StateModel withState({
    required StateEnum state,
  }) =>
      StateModel(
        loadingTagList: loadingTagList,
        themeMode: themeMode,
        token: (token == '') ? null : token,
        list: (token?.isNotEmpty ?? false) ? list : null,
        state: state,
        date: date,
        time: time,
      );

  StateModel withThemeMode({
    required ThemeMode themeMode,
  }) =>
      StateModel(
        loadingTagList: loadingTagList,
        themeMode: themeMode,
        token: token,
        list: list,
        state: state,
        date: date,
        time: time,
      );

  StateModel withToken({
    required String? token,
  }) =>
      StateModel(
        loadingTagList: loadingTagList,
        themeMode: themeMode,
        token: (token == '') ? null : token,
        list: (token?.isNotEmpty ?? false) ? list : null,
        state: state,
        date: date,
        time: time,
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

  static StateEnum selectState(
    Store<StateModel> store,
  ) =>
      store.state.state;
}
