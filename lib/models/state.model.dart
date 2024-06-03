import 'dart:typed_data' show Uint8List;

import 'package:flutter/material.dart' show ThemeMode, TimeOfDay, ValueGetter;
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
  final DateTime dateTime;
  final Uint8List? photoBytes;

  StateModel({
    required this.loadingTagList,
    required this.themeMode,
    required String? token,
    required ListModel? list,
    required this.state,
    required this.dateTime,
    required Uint8List? photoBytes,
  })  : token = (token != '') ? token : null,
        list = (token?.isNotEmpty ?? false) ? list : null,
        photoBytes = (token?.isNotEmpty ?? false) ? photoBytes : null;

  StateModel copyWith({
    ValueGetter<List<LoadingTagModel>>? loadingTagList,
    ValueGetter<ThemeMode>? themeMode,
    ValueGetter<String?>? token,
    ValueGetter<ListModel?>? list,
    ValueGetter<StateEnum>? state,
    ValueGetter<DateTime>? dateTime,
    ValueGetter<Uint8List?>? photoBytes,
  }) {
    final newLoadingTagList =
        (loadingTagList != null) ? loadingTagList.call() : this.loadingTagList;

    final newThemeMode =
        (themeMode != null) ? themeMode.call() : this.themeMode;

    final newToken = (token != null) ? token.call() : this.token;

    final newList = (list != null) ? list.call() : this.list;

    final newState = (state != null) ? state.call() : this.state;

    final wentFromListToPhoto =
        (this.state == StateEnum.list) && (newState == StateEnum.photo);

    final wentFromPhotoToList =
        (this.state == StateEnum.list) && (newState == StateEnum.photo);

    final newDateTime = wentFromListToPhoto
        ? DateTime.now()
        : (dateTime != null)
            ? dateTime.call()
            : this.dateTime;

    final newPhotoBytes = (wentFromListToPhoto || wentFromPhotoToList)
        ? null
        : (photoBytes != null)
            ? photoBytes.call()
            : this.photoBytes;

    return StateModel(
      loadingTagList: newLoadingTagList,
      themeMode: newThemeMode,
      token: newToken,
      list: newList,
      state: newState,
      dateTime: newDateTime,
      photoBytes: newPhotoBytes,
    );
  }

  StateModel withDate({
    required DateTime date,
  }) =>
      copyWith(
        dateTime: () => dateTime.copyWith(
          year: date.year,
          month: date.month,
          day: date.day,
        ),
      );

  StateModel withLoadingTagList({
    required List<LoadingTagModel> newLoadingTagList,
  }) =>
      copyWith(
        loadingTagList: () => loadingTagList + newLoadingTagList,
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

    return copyWith(
      loadingTagList: () => newLoadingTagList,
    );
  }

  StateModel withTime({
    required TimeOfDay time,
  }) =>
      copyWith(
          dateTime: () => dateTime.copyWith(
                hour: time.hour,
                minute: time.minute,
              ));

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
