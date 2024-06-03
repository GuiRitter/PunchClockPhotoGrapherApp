import 'package:flutter/material.dart' show BuildContext;
import 'package:provider/provider.dart' show Provider;
import 'package:punch_clock_photo_grapher_app/models/models.import.dart'
    show StateModel;
import 'package:punch_clock_photo_grapher_app/redux/data.action.dart'
    show DataAction, SetDateAction, SetPhotoAction, SetTimeAction;
import 'package:punch_clock_photo_grapher_app/redux/loading.action.dart'
    show AddLoadingAction, CancelLoadingAction, RemoveLoadingAction;
import 'package:punch_clock_photo_grapher_app/redux/navigation.action.dart'
    show NavigationAction;
import 'package:punch_clock_photo_grapher_app/redux/theme.action.dart'
    show ThemeAction;
import 'package:punch_clock_photo_grapher_app/redux/user.action.dart'
    show AuthenticationAction;
import 'package:punch_clock_photo_grapher_app/utils/utils.import.dart'
    show logger;

final _log = logger('main.reducer');

dynamic Function(
  dynamic,
) getDispatch({
  required BuildContext context,
}) =>
    Provider.of<
        dynamic Function(
          dynamic,
        )>(
      context,
      listen: false,
    );

StateModel reducer(
  StateModel stateModel,
  dynamic action,
) {
  _log('reducer').asString('action', action.runtimeType).print();

  return {
    AuthenticationAction: () => stateModel.copyWith(
          token: () => (action as AuthenticationAction).token,
        ),
    AddLoadingAction: () => stateModel.withLoadingTagList(
          newLoadingTagList: (action as AddLoadingAction).list,
        ),
    CancelLoadingAction: () => stateModel.withoutLoadingTagList(
          idList: [
            (action as CancelLoadingAction).id,
          ],
        ),
    DataAction: () => stateModel.copyWith(
          list: () => (action as DataAction).list,
        ),
    NavigationAction: () => stateModel.copyWith(
          state: () => (action as NavigationAction).state,
        ),
    RemoveLoadingAction: () => stateModel.withoutLoadingTagList(
          idList: (action as RemoveLoadingAction).idList,
        ),
    SetDateAction: () => stateModel.withDate(
          date: (action as SetDateAction).date,
        ),
    SetPhotoAction: () => stateModel.copyWith(
          photoBytes: () => (action as SetPhotoAction).photoBytes,
        ),
    SetTimeAction: () => stateModel.withTime(
          time: (action as SetTimeAction).time,
        ),
    ThemeAction: () => stateModel.copyWith(
          themeMode: () => (action as ThemeAction).themeMode,
        ),
    NoAction: () => stateModel,
  }[action.runtimeType]!();
}

class NoAction {}
