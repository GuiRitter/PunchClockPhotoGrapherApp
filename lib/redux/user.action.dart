import 'package:dio/dio.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:punch_clock_photo_grapher_app/common/api_url.enum.dart';
import 'package:punch_clock_photo_grapher_app/common/result_status.enum.dart';
import 'package:punch_clock_photo_grapher_app/common/settings.dart' as settings;
import 'package:punch_clock_photo_grapher_app/common/settings.dart';
import 'package:punch_clock_photo_grapher_app/main.dart';
import 'package:punch_clock_photo_grapher_app/models/sign_in.model.dart';
import 'package:punch_clock_photo_grapher_app/models/state.model.dart';
import 'package:punch_clock_photo_grapher_app/redux/loading.action.dart';
import 'package:punch_clock_photo_grapher_app/redux/main.reducer.dart';
import 'package:punch_clock_photo_grapher_app/utils/logger.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _api = settings.api;

final _log = logger("user.action");

ThunkAction<StateModel> clearToken() => (
      Store<StateModel> store,
    ) async {
      _log("clearToken").print();

      _api.options.headers.remove(
        settings.token,
      );

      var prefs = await SharedPreferences.getInstance();
      prefs.setString(
        settings.token,
        "",
      );

      return store.dispatch(
        const AuthenticationAction(
          token: null,
        ),
      );
    };

ThunkAction<StateModel> signIn({
  required SignInModel signInModel,
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
        settings.token,
        "",
      );

      final cancelToken = CancelToken();

      final loadingTag = buildLoadingTag(
        userFriendlyName: l10n.loadingTag_validateAndSetToken,
        cancelToken: cancelToken,
      );

      store.dispatch(
        addLoading(
          list: [
            loadingTag,
          ],
        ),
      );

      final result = await _api.postResult(
        ApiUrl.signIn.path,
        data: signInModel.toJson(),
        cancelToken: cancelToken,
      );

      store.dispatch(
        removeLoading(
          idList: [
            loadingTag.id,
          ],
        ),
      );

      if (result.status == ResultStatus.success) {
        final token = result.data[settings.data][settings.token];

        prefs.setString(
          settings.token,
          token,
        );

        _api.options.headers[settings.token] = token;

        store.dispatch(
          AuthenticationAction(
            token: token,
          ),
        );
      } else {
        showSnackBar(
          message: result.message,
        );
      }

      // TODO
      return store.dispatch(
        NoAction(),
      );

      // final searchResults = await new Future.delayed(
      //   new Duration(seconds: secondsToWait),
      //   () => "Search Results",
      // );
    };

ThunkAction<StateModel> signOut() => (
      Store<StateModel> store,
    ) async {
      _log("signOut").print();

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
      _log("validateAndSetToken").secret("newToken", newToken).print();

      if (store.state.token == newToken) {
        return store.dispatch(
          NoAction(),
        );
      }

      if (newToken == null) {
        return store.dispatch(
          clearToken(),
        );
      }

      _api.options.headers[settings.token] = newToken;

      final cancelToken = CancelToken();

      final context = navigatorState.currentContext!;

      final l10n = AppLocalizations.of(
        context,
      )!;

      final loadingTag = buildLoadingTag(
        userFriendlyName: l10n.loadingTag_validateAndSetToken,
        cancelToken: cancelToken,
      );

      store.dispatch(
        addLoading(
          list: [
            loadingTag,
          ],
        ),
      );

      final response = await _api.getResult(
        ApiUrl.checkToken.path,
        cancelToken: cancelToken,
      );

      store.dispatch(
        removeLoading(
          idList: [
            loadingTag.id,
          ],
        ),
      );

      if (response.status != ResultStatus.unauthorized) {
        store.dispatch(
          AuthenticationAction(
            token: response.data.toString(),
          ),
        );

        // TODO maybe call action to load data?
      } else {
        showSnackBar(
          message: response.message,
        );
      }

      // TODO
      return store.dispatch(
        NoAction(),
      );
    };

class AuthenticationAction {
  final String? token;

  const AuthenticationAction({
    required this.token,
  });
}
