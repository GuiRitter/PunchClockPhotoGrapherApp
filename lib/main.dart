import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:provider/provider.dart';
import 'package:punch_clock_photo_grapher_app/common/settings.dart'
    show l10nNotifier, navigatorState;
import 'package:punch_clock_photo_grapher_app/common/settings.dart' as settings;
import 'package:punch_clock_photo_grapher_app/models/loading_tag.model.dart';
import 'package:punch_clock_photo_grapher_app/models/state.model.dart';
import 'package:punch_clock_photo_grapher_app/redux/dio.action.dart';
import 'package:punch_clock_photo_grapher_app/redux/main.reducer.dart';
import 'package:punch_clock_photo_grapher_app/redux/user.action.dart'
    as user_action;
import 'package:punch_clock_photo_grapher_app/themes/dark.theme.dart';
import 'package:punch_clock_photo_grapher_app/themes/light.theme.dart';
import 'package:punch_clock_photo_grapher_app/ui/pages/tabs.page.dart';
import 'package:punch_clock_photo_grapher_app/utils/logger.dart';
import 'package:punch_clock_photo_grapher_app/utils/string.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // https://stackoverflow.com/questions/52489458/how-to-change-status-bar-color-in-flutter
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Color(
        0xFFeedc82,
      ),
    ),
  );

  SharedPreferences.getInstance().then(
    initializeApp,
  );
}

final _log = logger("main");

FutureOr initializeApp(
  SharedPreferences prefs,
) async {
  final themeName = prefs.getString(
    settings.themeKey,
  );

  _log("main SharedPreferences.getInstance").raw("theme", themeName).print();

  final theme = (themeName?.isNotEmpty ?? false)
      ? ThemeMode.values.byName(
          themeName!,
        )
      : ThemeMode.system;

  final token = prefs
      .getString(
        settings.tokenKey,
      )
      .nullIfEmpty;

  toggleToken(
    token: token,
  );

  final store = Store<StateModel>(
    reducer,
    initialState: StateModel(
      loadingTagList: <LoadingTagModel>[],
      themeMode: theme,
      token: token,
    ),
    middleware: [
      thunkMiddleware,
    ],
  );

  runApp(
    MyApp(
      store: store,
    ),
  );
}

void showSnackBar({
  required String? message,
}) {
  _log("showSnackBar").raw("message", message).print();

  settings.snackState.currentState!.showSnackBar(
    SnackBar(
      showCloseIcon: true,
      content: Text(
        message ?? "",
      ),
    ),
  );
}

String treatDioResponse({
  required dynamic response,
}) {
  if (response!.data is Map) {
    if ((response!.data as Map).containsKey(
      settings.errorKey,
    )) {
      return response!.data[settings.errorKey];
    }
  }
  return response!.data.toString();
}

String treatException({
  required dynamic exception,
}) {
  if (exception is DioException) {
    if (exception.response != null) {
      return treatDioResponse(
        response: exception.response,
      );
    } else if (exception.message != null) {
      return exception.message!;
    }
  }
  return exception.toString();
}

class MyApp extends StatelessWidget {
  final Store<StateModel> store;

  const MyApp({
    super.key,
    required this.store,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    _log("build").print();

    final dispatch = store.dispatch;

    final themeLight = light(
      context: context,
    );

    final themeDark = dark(
      context: context,
    );

    Future.microtask(
      validateAndSetToken,
    );

    return MultiProvider(
      providers: [
        Provider<
            dynamic Function(
              dynamic,
            )>.value(
          value: dispatch,
        ),
      ],
      child: StoreProvider<StateModel>(
        store: store,
        child: StoreConnector<StateModel, ThemeMode>(
          distinct: true,
          converter: (
            store,
          ) =>
              store.state.themeMode,
          builder: (
            context,
            themeMode,
          ) =>
              MaterialApp(
            title: "Punch Clock Photo Grapher",
            onGenerateTitle: getTitleLocalized,
            localeResolutionCallback: populateL10nNotifier,
            theme: themeLight,
            darkTheme: themeDark,
            themeMode: themeMode,
            home: const TabsPage(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            // TODO implement l10n switching
            supportedLocales: AppLocalizations.supportedLocales,
            navigatorKey: settings.navigatorState,
            scaffoldMessengerKey: settings.snackState,
          ),
        ),
      ),
    );
  }

  String getTitleLocalized(
    context,
  ) {
    final l10n = AppLocalizations.of(
      context,
    )!;

    return l10n.title;
  }

  Locale? populateL10nNotifier(
    Locale? locale,
    Iterable<Locale> supportedLocales,
  ) {
    AppLocalizations.delegate
        .load(
          locale!,
        )
        .then(
          (
            l10n,
          ) =>
              l10nNotifier.value = l10n,
        );

    return null;
  }

  FutureOr validateAndSetToken() {
    final context = navigatorState.currentContext!;

    final dispatch = getDispatch(
      context: context,
    );

    dispatch(
      user_action.validateAndSetToken(
        newToken: settings.revalidateToken,
      ),
    );
  }
}
