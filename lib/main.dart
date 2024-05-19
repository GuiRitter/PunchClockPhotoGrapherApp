import 'dart:async' show FutureOr;
import 'dart:io' show HttpOverrides;

import 'package:dio/dio.dart' show DioException;
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart'
    show
        BuildContext,
        Locale,
        MaterialApp,
        SnackBar,
        StatelessWidget,
        Text,
        ThemeMode,
        TimeOfDay,
        Widget,
        WidgetsFlutterBinding,
        runApp;
import 'package:flutter/services.dart'
    show SystemChrome, SystemUiOverlayStyle, Color;
import 'package:flutter_gen/gen_l10n/app_localizations.dart'
    show AppLocalizations;
import 'package:flutter_redux/flutter_redux.dart'
    show StoreConnector, StoreProvider;
import 'package:provider/provider.dart' show MultiProvider, Provider;
import 'package:punch_clock_photo_grapher_app/common/common.import.dart'
    show Settings, l10nNotifier, navigatorState, snackState, StateEnum;
import 'package:punch_clock_photo_grapher_app/models/models.import.dart'
    show LoadingTagModel, StateModel;
import 'package:punch_clock_photo_grapher_app/redux/dio.action.dart'
    as dio_action;
import 'package:punch_clock_photo_grapher_app/redux/main.reducer.dart'
    show getDispatch, reducer;
import 'package:punch_clock_photo_grapher_app/redux/user.action.dart'
    as user_action;
import 'package:punch_clock_photo_grapher_app/services/dio/my_http_overrides.dart'
    show MyHttpOverrides;
import 'package:punch_clock_photo_grapher_app/themes/themes.import.dart'
    show dark, light;
import 'package:punch_clock_photo_grapher_app/ui/pages/pages.import.dart'
    show TabsPage;
import 'package:punch_clock_photo_grapher_app/utils/utils.import.dart'
    show logger, StringExtension;
import 'package:redux/redux.dart' show Store;
import 'package:redux_thunk/redux_thunk.dart' show thunkMiddleware;
import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if (kDebugMode) {
    HttpOverrides.global = MyHttpOverrides();
  }

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

final _log = logger('main');

FutureOr initializeApp(
  SharedPreferences prefs,
) async {
  final themeName = prefs.getString(
    Settings.themeKey,
  );

  _log('main SharedPreferences.getInstance').raw('theme', themeName).print();

  final theme = (themeName?.isNotEmpty ?? false)
      ? ThemeMode.values.byName(
          themeName!,
        )
      : ThemeMode.system;

  final token = prefs
      .getString(
        Settings.tokenKey,
      )
      .nullIfEmpty;

  dio_action.toggleToken(
    token: token,
  );

  final store = Store<StateModel>(
    reducer,
    initialState: StateModel(
      loadingTagList: <LoadingTagModel>[],
      themeMode: theme,
      token: token,
      list: null,
      state: StateEnum.list,
      date: DateTime.now(),
      time: TimeOfDay.now(),
      photoFile: null,
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
  _log('showSnackBar').raw('message', message).print();

  snackState.currentState!.showSnackBar(
    SnackBar(
      showCloseIcon: true,
      content: Text(
        message ?? '',
      ),
    ),
  );
}

String treatDioResponse({
  required dynamic response,
}) {
  if (response!.data is Map) {
    if ((response!.data as Map).containsKey(
      Settings.errorKey,
    )) {
      return response!.data[Settings.errorKey];
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
    _log('build').print();

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
            title: 'Punch Clock Photo Grapher',
            onGenerateTitle: getTitleLocalized,
            localeResolutionCallback: populateL10nNotifier,
            theme: themeLight,
            darkTheme: themeDark,
            themeMode: themeMode,
            home: const TabsPage(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            // TODO implement l10n switching
            supportedLocales: AppLocalizations.supportedLocales,
            navigatorKey: navigatorState,
            scaffoldMessengerKey: snackState,
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
        newToken: Settings.revalidateToken,
      ),
    );
  }
}
