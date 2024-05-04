import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:punch_clock_photo_grapher_app/common/settings.dart';
import 'package:punch_clock_photo_grapher_app/models/state.model.dart';
import 'package:punch_clock_photo_grapher_app/redux/main.reducer.dart';
import 'package:punch_clock_photo_grapher_app/redux/theme.action.dart';
import 'package:punch_clock_photo_grapher_app/utils/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _log = logger("ThemeOptionWidget");

class ThemeOptionWidget extends StatelessWidget {
  final ThemeMode themeMode;
  final String title;

  const ThemeOptionWidget({
    super.key,
    required this.themeMode,
    required this.title,
  });

  @override
  Widget build(
    BuildContext context,
  ) =>
      StoreConnector<StateModel, ThemeMode>(
        distinct: true,
        converter: (
          store,
        ) =>
            store.state.themeMode,
        builder: (
          context,
          themeModeCurrent,
        ) =>
            ListTile(
          onTap: () => onThemeTapped(
            context: context,
            themeMode: themeMode,
          ),
          title: Text(
            title,
          ),
          trailing: Icon(
            (themeModeCurrent == themeMode)
                ? Icons.radio_button_checked
                : Icons.radio_button_unchecked,
          ),
        ),
      );

  onThemeTapped({
    required BuildContext context,
    required ThemeMode themeMode,
  }) {
    _log("onThemeTapped").enum_("themeMode", themeMode).print();

    final dispatch = getDispatch(
      context: context,
    );

    dispatch(
      ThemeAction(
        themeMode: themeMode,
      ),
    );

    SharedPreferences.getInstance().then(
      (
        prefs,
      ) {
        prefs.setString(
          themeKey,
          themeMode.name,
        );
      },
    );

    Navigator.pop(
      context,
    );
  }
}
