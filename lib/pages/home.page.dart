import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:punch_clock_photo_grapher_mobile/blocs/user.bloc.dart';
import 'package:punch_clock_photo_grapher_mobile/constants/settings.dart';
import 'package:punch_clock_photo_grapher_mobile/main.dart';
import 'package:punch_clock_photo_grapher_mobile/models/sign_in.model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  static String? _userId;

  static String? _password;
  final _formKey = GlobalKey<FormState>();

  HomePage({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    final bloc = Provider.of<UserBloc>(
      context,
    );

    SharedPreferences.getInstance().then(
      (
        prefs,
      ) {
        var token = prefs.getString(
          Settings.token,
        );
        if (token?.isNotEmpty ?? false) {
          bloc
              .validateAndSetToken(
            newToken: token,
          )
              .then(
            (
              result,
            ) {
              if (result.message != null) {
                showSnackBar(
                  message: result.message,
                );
              }
            },
          );
        }
      },
    );

    var l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(
            context,
          )!
              .title,
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(
            Theme.of(
                  context,
                ).textTheme.titleLarge?.fontSize ??
                0,
          ),
          child: Form(
            key: _formKey,
            child: AutofillGroup(
              child: Column(
                children: [
                  TextFormField(
                    autofillHints: const [
                      AutofillHints.username,
                    ],
                    decoration: InputDecoration(
                      labelText: l10n.userID,
                    ),
                    keyboardType: TextInputType.text,
                    onSaved: (
                      input,
                    ) =>
                        _userId = input,
                    validator: (
                      value,
                    ) =>
                        (value?.isEmpty ?? true) ? l10n.invalidUserID : null,
                  ),
                  TextFormField(
                    autofillHints: const [
                      AutofillHints.password,
                    ],
                    decoration: InputDecoration(
                      labelText: l10n.password,
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    onSaved: (
                      input,
                    ) =>
                        _password = input,
                    validator: (
                      value,
                    ) =>
                        (value?.isEmpty ?? true) ? l10n.invalidPassword : null,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: Theme.of(
                            context,
                          ).textTheme.titleLarge?.fontSize ??
                          0,
                    ),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (!(_formKey.currentState?.validate() ?? false)) {
                          return;
                        }

                        _formKey.currentState?.save();

                        TextInput.finishAutofillContext();

                        try {
                          await bloc.signIn(
                            SignInModel(
                              userId: _userId ?? "",
                              password: _password ?? "",
                            ),
                          );
                        } catch (exception) {
                          showSnackBar(
                            message: treatException(
                              exception: exception,
                            ),
                          );
                        }
                      },
                      child: Text(
                        l10n.signIn,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
