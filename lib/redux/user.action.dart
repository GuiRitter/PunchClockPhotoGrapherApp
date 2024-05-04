import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:punch_clock_photo_grapher_app/common/api_url.enum.dart';
import 'package:punch_clock_photo_grapher_app/common/settings.dart' as settings;
import 'package:punch_clock_photo_grapher_app/common/settings.dart';
import 'package:punch_clock_photo_grapher_app/models/result.dart';
import 'package:punch_clock_photo_grapher_app/models/sign_in.request.model.dart';
import 'package:punch_clock_photo_grapher_app/models/state.model.dart';
import 'package:punch_clock_photo_grapher_app/redux/dio.action.dart'
    as dio_action;
import 'package:punch_clock_photo_grapher_app/redux/main.reducer.dart';
import 'package:punch_clock_photo_grapher_app/utils/logger.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _log = logger("user.action");

ThunkAction<StateModel> clearToken() => (
      Store<StateModel> store,
    ) async {
      _log("clearToken").print();

      dio_action.clearToken();

      var prefs = await SharedPreferences.getInstance();
      prefs.setString(
        settings.tokenKey,
        "",
      );

      return store.dispatch(
        const AuthenticationAction(
          token: null,
        ),
      );
    };

ThunkAction<StateModel> signIn({
  required SignInRequestModel signInModel,
  required AppLocalizations l10n,
}) =>
    (
      Store<StateModel> store,
    ) async {
      _log("signIn").map("signInModel", signInModel).print();

      final context = navigatorState.currentContext!;

      final l10n = AppLocalizations.of(
        context,
      )!;

      var prefs = await SharedPreferences.getInstance();

      prefs.setString(
        settings.tokenKey,
        "",
      );

      signInSuccess({
        required Result result,
      }) async {
        _log("signInSuccess").map("result", result).print();

        final token =
            result.data[settings.dataKey][settings.tokenKey] as String;

        prefs.setString(
          settings.tokenKey,
          token,
        );

        dio_action.setToken(
          token: token,
        );

        store.dispatch(
          AuthenticationAction(
            token: token,
          ),
        );
      }

      signInFailure({
        required Result result,
      }) async =>
          store.dispatch(
            clearToken(),
          );

      store.dispatch(
        dio_action.post(
          url: ApiUrl.signIn.path,
          data: signInModel,
          userFriendlyName: l10n.loadingTag_validateAndSetToken,
          thenFunction: signInSuccess,
          catchFunction: signInFailure,
          l10n: l10n,
        ),
      );

      // // TODO
      // final searchResults = await new Future.delayed(
      //   new Duration(seconds: secondsToWait),
      //   () => "Search Results",
      // );
    };

ThunkAction<StateModel> signOut({
  required AppLocalizations l10n,
}) =>
    (
      Store<StateModel> store,
    ) async {
      _log("signOut").print();

      return store.dispatch(
        validateAndSetToken(
          newToken: null,
          l10n: l10n,
        ),
      );
    };

ThunkAction<StateModel> validateAndSetToken({
  required String? newToken,
  required AppLocalizations l10n,
}) =>
    (
      Store<StateModel> store,
    ) async {
      _log("validateAndSetToken").secret("newToken", newToken).print();

      if (newToken == settings.revalidateToken) {
        newToken = store.state.token;
      } else if (store.state.token == newToken) {
        return store.dispatch(
          NoAction(),
        );
      }

      if (newToken?.isEmpty ?? true) {
        return store.dispatch(
          clearToken(),
        );
      }

      dio_action.setToken(
        token: newToken!,
      );

      checkTokenSuccess({
        required Result result,
      }) async {
        _log("checkTokenSuccess").map("result", result).print();

        store.dispatch(
          AuthenticationAction(
            token: result.data.toString(),
          ),
        );
      }

      checkTokenFailure({
        required Result result,
      }) async =>
          store.dispatch(
            clearToken(),
          );

      store.dispatch(
        dio_action.get(
          url: ApiUrl.checkToken.path,
          userFriendlyName: l10n.loadingTag_validateAndSetToken,
          thenFunction: checkTokenSuccess,
          catchFunction: checkTokenFailure,
          l10n: l10n,
        ),
      );
    };

class AuthenticationAction {
  final String? token;

  const AuthenticationAction({
    required this.token,
  });
}
