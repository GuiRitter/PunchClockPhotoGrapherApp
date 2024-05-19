import 'package:flutter/material.dart' show ThemeMode, TimeOfDay;
import 'package:image_picker/image_picker.dart' show XFile;
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
  final XFile? photoFile;

  StateModel({
    required this.loadingTagList,
    required this.themeMode,
    required this.token,
    required list,
    required this.state,
    required this.date,
    required this.time,
    required this.photoFile,
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
        photoFile: photoFile,
      );

  StateModel withDate({
    required DateTime date,
  }) =>
      StateModel(
        loadingTagList: loadingTagList,
        themeMode: themeMode,
        token: token,
        list: list,
        state: state,
        date: date,
        time: time,
        photoFile: photoFile,
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
        photoFile: photoFile,
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
      photoFile: photoFile,
    );
  }

  StateModel withPhotoFile({
    required XFile photoFile,
  }) =>
      StateModel(
        loadingTagList: loadingTagList,
        themeMode: themeMode,
        token: token,
        list: list,
        state: state,
        date: date,
        time: time,
        photoFile: photoFile,
      );

  StateModel withState({
    required StateEnum state,
  }) {
    final wentFromListToPhoto =
        (this.state == StateEnum.list) && (state == StateEnum.photo);

    return StateModel(
      loadingTagList: loadingTagList,
      themeMode: themeMode,
      token: (token == '') ? null : token,
      list: (token?.isNotEmpty ?? false) ? list : null,
      state: state,
      date: wentFromListToPhoto ? DateTime.now() : date,
      time: wentFromListToPhoto ? TimeOfDay.now() : time,
      photoFile: wentFromListToPhoto ? null : photoFile,
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
        state: state,
        date: date,
        time: time,
        photoFile: photoFile,
      );

  StateModel withTime({
    required TimeOfDay time,
  }) =>
      StateModel(
        loadingTagList: loadingTagList,
        themeMode: themeMode,
        token: token,
        list: list,
        state: state,
        date: date,
        time: time,
        photoFile: photoFile,
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
        photoFile: (token?.isNotEmpty ?? false) ? photoFile : null,
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
