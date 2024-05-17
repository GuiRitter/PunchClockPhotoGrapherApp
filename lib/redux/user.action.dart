import 'package:flutter_gen/gen_l10n/app_localizations.dart'
    show AppLocalizations;
import 'package:punch_clock_photo_grapher_app/common/common.import.dart'
    show ApiUrl, l10n, navigatorState, Settings;
import 'package:punch_clock_photo_grapher_app/models/models.import.dart'
    show Result, SignInRequestModel, StateModel;
import 'package:punch_clock_photo_grapher_app/redux/dio.action.dart'
    as dio_action;
import 'package:punch_clock_photo_grapher_app/utils/utils.import.dart'
    show logger;
import 'package:redux/redux.dart' show Store;
import 'package:redux_thunk/redux_thunk.dart' show ThunkAction;
import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;

final _log = logger('user.action');

ThunkAction<StateModel> clearToken() => (
      Store<StateModel> store,
    ) async {
      _log('clearToken').print();

      dio_action.clearToken();

      var prefs = await SharedPreferences.getInstance();
      prefs.setString(
        Settings.tokenKey,
        '',
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
      _log('signIn').map('signInModel', signInModel).print();

      final context = navigatorState.currentContext!;

      final l10n = AppLocalizations.of(
        context,
      )!;

      var prefs = await SharedPreferences.getInstance();

      prefs.setString(
        Settings.tokenKey,
        '',
      );

      signInSuccess({
        required Result result,
      }) async {
        _log('signInSuccess').map('result', result).print();

        final token =
            result.data[Settings.dataKey][Settings.tokenKey] as String;

        prefs.setString(
          Settings.tokenKey,
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
        ),
      );

      // // TODO
      // final searchResults = await new Future.delayed(
      //   new Duration(seconds: secondsToWait),
      //   () => 'Search Results',
      // );
    };

ThunkAction<StateModel> signOut() => (
      Store<StateModel> store,
    ) async {
      _log('signOut').print();

      return store.dispatch(
        validateAndSetToken(
          newToken: null,
        ),
      );
    };

ThunkAction<StateModel> validateAndSetToken({
  required String? newToken,
}) =>
    (
      Store<StateModel> store,
    ) async {
      _log('validateAndSetToken').secret('newToken', newToken).print();

      if (newToken == Settings.revalidateToken) {
        newToken = store.state.token;
      } else if (store.state.token == newToken) {
        return;
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
        _log('checkTokenSuccess').map('result', result).print();

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
        ),
      );
    };

class AuthenticationAction {
  final String? token;

  const AuthenticationAction({
    required this.token,
  });
}
