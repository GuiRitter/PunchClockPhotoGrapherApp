import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:punch_clock_photo_grapher_app/models/state.model.dart';
import 'package:punch_clock_photo_grapher_app/redux/loading.action.dart';
import 'package:punch_clock_photo_grapher_app/redux/theme.action.dart';
import 'package:punch_clock_photo_grapher_app/redux/user.action.dart';
import 'package:punch_clock_photo_grapher_app/utils/logger.dart';

final _log = logger("main.reducer");

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
  _log("reducer").asString("action", action.runtimeType).print();

  return {
    AuthenticationAction: () => stateModel.withToken(
          token: (action as AuthenticationAction).token,
        ),
    AddLoadingAction: () => stateModel.withLoadingTagList(
          newLoadingTagList: (action as AddLoadingAction).list,
        ),
    CancelLoadingAction: () => stateModel.withoutLoadingTagList(
          idList: [
            (action as CancelLoadingAction).id,
          ],
        ),
    RemoveLoadingAction: () => stateModel.withoutLoadingTagList(
          idList: (action as RemoveLoadingAction).idList,
        ),
    ThemeAction: () => stateModel.withThemeMode(
          themeMode: (action as ThemeAction).themeMode,
        ),
    NoAction: () => stateModel,
  }[action.runtimeType]!();
}

class NoAction {}
