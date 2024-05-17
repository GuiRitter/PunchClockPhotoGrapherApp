import 'package:flutter/material.dart'
    show
        BuildContext,
        Icon,
        Icons,
        ListTile,
        Navigator,
        StatelessWidget,
        Text,
        ThemeMode,
        Widget;
import 'package:flutter_redux/flutter_redux.dart' show StoreConnector;
import 'package:punch_clock_photo_grapher_app/common/common.import.dart'
    show Settings;
import 'package:punch_clock_photo_grapher_app/models/models.import.dart'
    show StateModel;
import 'package:punch_clock_photo_grapher_app/redux/main.reducer.dart'
    show getDispatch;
import 'package:punch_clock_photo_grapher_app/redux/theme.action.dart'
    as theme_action;
import 'package:punch_clock_photo_grapher_app/utils/utils.import.dart'
    show logger;
import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;

final _log = logger('ThemeOptionWidget');

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
    _log('onThemeTapped').enum_('themeMode', themeMode).print();

    final dispatch = getDispatch(
      context: context,
    );

    dispatch(
      theme_action.ThemeAction(
        themeMode: themeMode,
      ),
    );

    SharedPreferences.getInstance().then(
      (
        prefs,
      ) {
        prefs.setString(
          Settings.themeKey,
          themeMode.name,
        );
      },
    );

    Navigator.pop(
      context,
    );
  }
}
