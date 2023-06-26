import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:punch_clock_photo_grapher_mobile_bloc/blocs/user.bloc.dart';
import 'package:punch_clock_photo_grapher_mobile_bloc/constants/settings.dart';
import 'package:punch_clock_photo_grapher_mobile_bloc/main.dart';
import 'package:punch_clock_photo_grapher_mobile_bloc/models/sign_in.model.dart';
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
    var bloc = Provider.of<UserBloc>(
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

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Punch Clock Photo Grapher",
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
                    decoration: const InputDecoration(
                      labelText: "User ID",
                    ),
                    keyboardType: TextInputType.text,
                    onSaved: (
                      input,
                    ) =>
                        _userId = input,
                    validator: (
                      value,
                    ) =>
                        (value?.isEmpty ?? true) ? "Invalid user ID." : null,
                  ),
                  TextFormField(
                    autofillHints: const [
                      AutofillHints.password,
                    ],
                    decoration: const InputDecoration(
                      labelText: "Password",
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
                        (value?.isEmpty ?? true) ? "Invalid password." : null,
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
                      child: const Text(
                        "Sign in",
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
