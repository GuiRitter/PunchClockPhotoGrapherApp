import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:provider/provider.dart';
import 'package:punch_clock_photo_grapher_app/common/settings.dart' as settings;
import 'package:punch_clock_photo_grapher_app/models/loading_cancel_token.model.dart';
import 'package:punch_clock_photo_grapher_app/models/state.model.dart';
import 'package:punch_clock_photo_grapher_app/redux/main.reducer.dart';
import 'package:punch_clock_photo_grapher_app/redux/theme.action.dart';
import 'package:punch_clock_photo_grapher_app/themes/dark.theme.dart';
import 'package:punch_clock_photo_grapher_app/themes/light.theme.dart';
import 'package:punch_clock_photo_grapher_app/ui/pages/tabs.page.dart';
import 'package:punch_clock_photo_grapher_app/utils/logger.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  final store = Store<StateModel>(
    reducer,
    initialState: StateModel(
      loadingTagList: <LoadingTagModel>[],
      themeMode: ThemeMode.system,
      token: null,
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

final _log = logger("main");

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
      settings.error,
    )) {
      return response!.data[settings.error];
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
    final dispatch = store.dispatch;

    SharedPreferences.getInstance().then(
      (
        prefs,
      ) {
        final themeName = prefs.getString(settings.themeKey);

        _log("build SharedPreferences.getInstance")
            .raw("theme", themeName)
            .print();

        if (themeName?.isNotEmpty ?? false) {
          final theme = ThemeMode.values.byName(
            themeName!,
          );

          dispatch(
            ThemeAction(
              themeMode: theme,
            ),
          );
        }
      },
    );

    final themeLight = light(
      context: context,
    );

    final themeDark = dark(
      context: context,
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
            onGenerateTitle: (
              context,
            ) {
              final l10n = AppLocalizations.of(
                context,
              )!;

              return l10n.title;
            },
            theme: themeLight,
            darkTheme: themeDark,
            themeMode: themeMode,
            home: const TabsPage(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            navigatorKey: settings.navigatorState,
            scaffoldMessengerKey: settings.snackState,
          ),
        ),
      ),
    );
  }
}
