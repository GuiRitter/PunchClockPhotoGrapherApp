import 'dart:typed_data' show Uint8List;

import 'package:flutter/material.dart' show ThemeMode, TimeOfDay, ValueGetter;
import 'package:flutter_guiritter/common/_import.dart'
    show AppLocalizationsGuiRitter;
import 'package:flutter_guiritter/common/_import.dart' as common_gui_ritter;
import 'package:flutter_guiritter/model/_import.dart' as model_gui_ritter;
import 'package:flutter_guiritter/model/_import.dart' show LoadingTagModel;
import 'package:punch_clock_photo_grapher_app/common/_import.dart'
    show AppLocalizations, StateEnum, StateKey;
import 'package:punch_clock_photo_grapher_app/model/_import.dart'
    show ListModel;
import 'package:redux/redux.dart' show Store;

class StateModelWrapper
    extends model_gui_ritter.StateModelWrapper<AppLocalizations> {
  StateModelWrapper({
    required super.storeStateMap,
  });

  StateModelWrapper.init({
    required AppLocalizations? l10n,
    required AppLocalizationsGuiRitter? l10nGuiRitter,
    required List<LoadingTagModel> loadingTagList,
    required String? token,
    required ThemeMode themeMode,
    required ListModel? list,
    required StateEnum state,
    required DateTime dateTime,
    required Uint8List? photoByteList,
  }) : this(
          storeStateMap: {
            common_gui_ritter.StateKey.l10n: l10n,
            common_gui_ritter.StateKey.l10nGuiRitter: l10nGuiRitter,
            common_gui_ritter.StateKey.loadingTagList: loadingTagList,
            common_gui_ritter.StateKey.themeMode: themeMode,
            common_gui_ritter.StateKey.token: token,
            StateKey.list: list,
            StateKey.state: state,
            StateKey.dateTime: dateTime,
            StateKey.photoByteList: photoByteList,
          },
        );

  DateTime get dateTime => getDateTime(
        storeStateMap: storeStateMap,
      );

  set dateTime(
    DateTime dateTime,
  ) =>
      setDateTime(
        storeStateMap: storeStateMap,
        dateTime: dateTime,
      );

  ListModel? get list => getList(
        storeStateMap: storeStateMap,
      );

  set list(
    ListModel? list,
  ) =>
      setList(
        storeStateMap: storeStateMap,
        list: list,
      );

  Uint8List? get photoByteList => getPhotoByteList(
        storeStateMap: storeStateMap,
      );

  set photoByteList(
    Uint8List? photoByteList,
  ) =>
      setPhotoByteList(
        storeStateMap: storeStateMap,
        photoByteList: photoByteList,
      );

  StateEnum get state => getState(
        storeStateMap: storeStateMap,
      );

  set state(
    StateEnum state,
  ) =>
      setState(
        storeStateMap: storeStateMap,
        state: state,
      );

  @override
  Map<String, dynamic> copyWith({
    ValueGetter<AppLocalizations?>? l10n,
    ValueGetter<AppLocalizationsGuiRitter?>? l10nGuiRitter,
    ValueGetter<List<LoadingTagModel>>? loadingTagList,
    ValueGetter<ThemeMode>? themeMode,
    ValueGetter<String?>? token,
    ValueGetter<ListModel?>? list,
    ValueGetter<StateEnum>? state,
    ValueGetter<DateTime>? dateTime,
    ValueGetter<Uint8List?>? photoByteList,
  }) =>
      buildNewMap(
        storeStateMap: storeStateMap,
        l10n: l10n,
        l10nGuiRitter: l10nGuiRitter,
        themeMode: themeMode,
        token: token,
        loadingTagList: loadingTagList,
        list: list,
        state: state,
        dateTime: dateTime,
        photoByteList: photoByteList,
      );

  Map<String, dynamic> withDate({
    required DateTime date,
  }) =>
      copyWith(
        dateTime: () => dateTime.copyWith(
          year: date.year,
          month: date.month,
          day: date.day,
        ),
      );

  Map<String, dynamic> withTime({
    required TimeOfDay time,
  }) =>
      copyWith(
          dateTime: () => dateTime.copyWith(
                hour: time.hour,
                minute: time.minute,
              ));

  static Map<String, dynamic> buildNewMap({
    required Map<String, dynamic> storeStateMap,
    ValueGetter<AppLocalizations?>? l10n,
    ValueGetter<AppLocalizationsGuiRitter?>? l10nGuiRitter,
    ValueGetter<List<LoadingTagModel>>? loadingTagList,
    ValueGetter<ThemeMode>? themeMode,
    ValueGetter<String?>? token,
    ValueGetter<ListModel?>? list,
    ValueGetter<StateEnum>? state,
    ValueGetter<DateTime>? dateTime,
    ValueGetter<Uint8List?>? photoByteList,
  }) {
    final storeStateMapNew = model_gui_ritter.StateModelWrapper.buildNewMap(
      storeStateMap: storeStateMap,
      l10n: l10n,
      l10nGuiRitter: l10nGuiRitter,
      themeMode: themeMode,
      loadingTagList: loadingTagList,
      token: token,
    );

    final storeStateWrapperCurrent = StateModelWrapper(
      storeStateMap: storeStateMap,
    );

    final newList =
        (list != null) ? list.call() : storeStateWrapperCurrent.list?.clone();

    final newState =
        (state != null) ? state.call() : storeStateWrapperCurrent.state;

    final wentFromListToPhoto =
        (storeStateWrapperCurrent.state == StateEnum.list) &&
            (newState == StateEnum.photo);

    final wentFromPhotoToList =
        (storeStateWrapperCurrent.state == StateEnum.list) &&
            (newState == StateEnum.photo);

    final newDateTime = wentFromListToPhoto
        ? DateTime.now()
        : (dateTime != null)
            ? dateTime.call()
            : storeStateWrapperCurrent.dateTime;

    final newPhotoBytes = (wentFromListToPhoto || wentFromPhotoToList)
        ? null
        : (photoByteList != null)
            ? photoByteList.call()
            : storeStateWrapperCurrent.photoByteList;

    storeStateMapNew[StateKey.list] = newList;
    storeStateMapNew[StateKey.state] = newState;
    storeStateMapNew[StateKey.dateTime] = newDateTime;
    storeStateMapNew[StateKey.photoByteList] = newPhotoBytes;

    return storeStateMapNew;
  }

  static DateTime getDateTime({
    required Map<String, dynamic> storeStateMap,
  }) =>
      storeStateMap[StateKey.dateTime] as DateTime;

  static ListModel? getList({
    required Map<String, dynamic> storeStateMap,
  }) =>
      storeStateMap[StateKey.list] as ListModel?;

  static Uint8List? getPhotoByteList({
    required Map<String, dynamic> storeStateMap,
  }) =>
      storeStateMap[StateKey.photoByteList] as Uint8List?;

  static StateEnum getState({
    required Map<String, dynamic> storeStateMap,
  }) =>
      storeStateMap[StateKey.state] as StateEnum;

  static bool selectIsLoading(
    Store<Map<String, dynamic>> store,
  ) {
    final state = StateModelWrapper(
      storeStateMap: store.state,
    );

    return state.loadingTagList.isNotEmpty;
  }

  static bool selectIsSignedIn(
    Store<Map<String, dynamic>> store,
  ) {
    final state = StateModelWrapper(
      storeStateMap: store.state,
    );

    return state.token?.isNotEmpty ?? false;
  }

  static StateEnum selectState(
    Store<Map<String, dynamic>> store,
  ) {
    final state = StateModelWrapper(
      storeStateMap: store.state,
    );

    return state.state;
  }

  static setDateTime({
    required Map<String, dynamic> storeStateMap,
    required DateTime dateTime,
  }) =>
      storeStateMap[StateKey.dateTime] = dateTime;

  static setList({
    required Map<String, dynamic> storeStateMap,
    required ListModel? list,
  }) =>
      storeStateMap[StateKey.list] = list;

  static setPhotoByteList({
    required Map<String, dynamic> storeStateMap,
    required Uint8List? photoByteList,
  }) =>
      storeStateMap[StateKey.photoByteList] = photoByteList;

  static setState({
    required Map<String, dynamic> storeStateMap,
    required StateEnum state,
  }) =>
      storeStateMap[StateKey.state] = state;
}
