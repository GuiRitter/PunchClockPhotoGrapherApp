import 'package:flutter/material.dart'
    show
        BuildContext,
        Icon,
        Icons,
        ListTile,
        Navigator,
        StatelessWidget,
        ThemeMode,
        Widget;
import 'package:flutter_guiritter/common/common.import.dart' show Settings;
import 'package:flutter_guiritter/redux/redux.import.dart' show dispatch;
import 'package:flutter_guiritter/redux/theme/action.dart'
    as theme_action_gui_ritter;
import 'package:flutter_guiritter/util/util.import.dart' show logger;
import 'package:flutter_redux/flutter_redux.dart' show StoreConnector;
import 'package:punch_clock_photo_grapher_app/models/models.import.dart'
    show StateModel;
import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;

// TODO delete

final _log = logger('ThemeOptionWidget');

class ThemeOptionWidget extends StatelessWidget {
  final ThemeMode themeMode;
  final Widget title;

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
          title: title,
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

    dispatch(
      theme_action_gui_ritter.ThemeAction(
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
