import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:punch_clock_photo_grapher_mobile_bloc/blocs/user.bloc.dart';
import 'package:punch_clock_photo_grapher_mobile_bloc/main.dart';
import 'package:punch_clock_photo_grapher_mobile_bloc/models/sign_in.model.dart';
import 'package:punch_clock_photo_grapher_mobile_bloc/models/system_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  HomePage({
    super.key,
  });

  static String? _userId;
  static String? _password;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(
    BuildContext context,
  ) {
    var bloc = Provider.of<UserBloc>(
      context,
    );

    // TODO fix this: should validate the token first
    SharedPreferences.getInstance().then(
      (
        prefs,
      ) {
        var token = prefs.getString(
          SystemConstants.token,
        );
        if (token?.isNotEmpty ?? false) {
          bloc.token = token;
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
            child: Column(
              children: [
                TextFormField(
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

                      try {
                        await bloc.signIn(
                          SignInModel(
                            userId: _userId ?? "",
                            password: _password ?? "",
                          ),
                        );
                      } catch (exception) {
                        showSnackBar(
                          context: context,
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
    );
  }
}
