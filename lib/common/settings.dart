import 'package:flutter/material.dart'
    show
        GlobalKey,
        Locale,
        NavigatorState,
        ScaffoldMessengerState,
        ValueNotifier;
import 'package:flutter_gen/gen_l10n/app_localizations.dart'
    show AppLocalizations;
import 'package:punch_clock_photo_grapher_app/services/dio/dio_for_any.interface.dart'
    show DioForAny;

const appName = 'punch_clock_photo_grapher';

const base64Prefix = 'data:image/png;base64,';

final l10nNotifier = ValueNotifier<AppLocalizations?>(
  null,
);

final navigatorState = GlobalKey<NavigatorState>();

final snackState = GlobalKey<ScaffoldMessengerState>();

AppLocalizations get l10n => l10nNotifier.value!;

class Settings {
  static final api = DioForAny();

  static const apiUrl = '$protocol://$domain$port/$path/';

  static const dataKey = 'data';

  static const domain = 'guilherme-alan-ritter.net';

// static const domain = 'localhost';
// static const domain = '127.0.0.1';
// static const domain = '10.0.2.2';

  static const errorKey = 'error';

  static String locale = const Locale.fromSubtags(
    languageCode: "en",
  ).toString();

  static const path = '$appName/api';

  static const port = '';

// static const port = ':49235';

  static const protocol = 'https';

// static const protocol = 'http';

  static const revalidateToken = 'REVALIDATE_TOKEN';

  static const themeKey = 'theme';

  static const tokenKey = 'token';
}
