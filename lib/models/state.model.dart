import 'dart:typed_data' show Uint8List;

import 'package:flutter/material.dart' show ThemeMode, TimeOfDay, ValueGetter;
import 'package:flutter_guiritter/common/common.import.dart'
    as common_gui_ritter show AppLocalizationsGuiRitter;
import 'package:flutter_guiritter/model/model.import.dart' as model_gui_ritter
    show LoadingTagModel, StateModel;
import 'package:punch_clock_photo_grapher_app/common/common.import.dart'
    show AppLocalizations, StateEnum;
import 'package:punch_clock_photo_grapher_app/models/models.import.dart'
    show ListModel;
import 'package:redux/redux.dart' show Store;

class StateModel extends model_gui_ritter.StateModel<AppLocalizations> {
  final ListModel? list;
  final StateEnum state;
  final DateTime dateTime;
  final Uint8List? photoBytes;

  StateModel({
    super.l10n,
    super.l10nGuiRitter,
    required super.loadingTagList,
    super.token,
    required super.themeMode,
    required ListModel? list,
    required this.state,
    required this.dateTime,
    required Uint8List? photoBytes,
  })  : list = (token?.isNotEmpty ?? false) ? list : null,
        photoBytes = (token?.isNotEmpty ?? false) ? photoBytes : null;

  @override
  StateModel copyWith({
    ValueGetter<AppLocalizations?>? l10n,
    ValueGetter<common_gui_ritter.AppLocalizationsGuiRitter?>? l10nGuiRitter,
    ValueGetter<List<model_gui_ritter.LoadingTagModel>>? loadingTagList,
    ValueGetter<ThemeMode>? themeMode,
    ValueGetter<String?>? token,
    ValueGetter<ListModel?>? list,
    ValueGetter<StateEnum>? state,
    ValueGetter<DateTime>? dateTime,
    ValueGetter<Uint8List?>? photoBytes,
  }) {
    final newL10n = (l10n != null) ? l10n.call() : this.l10n;

    final newL10nGuiRitter =
        (l10nGuiRitter != null) ? l10nGuiRitter.call() : this.l10nGuiRitter;

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
      l10n: newL10n,
      l10nGuiRitter: newL10nGuiRitter,
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
    required List<model_gui_ritter.LoadingTagModel> newLoadingTagList,
  }) =>
      copyWith(
        loadingTagList: () => loadingTagList + newLoadingTagList,
      );

  StateModel withoutLoadingTagList({
    required List<String> idList,
  }) {
    final newLoadingTagList =
        List<model_gui_ritter.LoadingTagModel>.from(loadingTagList);

    for (final id in idList) {
      final index = newLoadingTagList.indexWhere(
        model_gui_ritter.LoadingTagModel.idEquals(
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

  static bool selectIsL10nLoaded(
    Store<StateModel> store,
  ) =>
      (store.state.l10nGuiRitter != null) && (store.state.l10n != null);

  static bool selectIsLoading(
    Store<StateModel> store,
  ) =>
      store.state.loadingTagList.isNotEmpty;

  static bool selectIsSignedIn(
    Store<StateModel> store,
  ) =>
      store.state.token?.isNotEmpty ?? false;

  static List<model_gui_ritter.LoadingTagModel> selectLoadingTagList(
    Store<StateModel> store,
  ) =>
      store.state.loadingTagList;

  static StateEnum selectState(
    Store<StateModel> store,
  ) =>
      store.state.state;
}
