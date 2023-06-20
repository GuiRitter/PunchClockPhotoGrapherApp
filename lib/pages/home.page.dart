import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:punch_clock_photo_grapher_mobile_bloc/blocs/user.bloc.dart';
import 'package:punch_clock_photo_grapher_mobile_bloc/main.dart';
import 'package:punch_clock_photo_grapher_mobile_bloc/models/sign_in.model.dart';

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
    // TODO auto login when token is in the storage
    // TODO fix this: should validate the token first
    // SharedPreferences.getInstance().then((
    //   prefs,
    // ) {
    //   var token = prefs.getString(
    //     SystemConstants.token,
    //   );
    //   if ((token != null) && (token.isNotEmpty)) {
    //     getCamera().then(
    //       (
    //         camera,
    //       ) =>
    //           navigate(
    //         context,
    //         CameraPage(
    //           camera: camera,
    //         ),
    //       ),
    //     );
    //   }
    // });
    var bloc = Provider.of<UserBloc>(context);

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
                      ((value == null) || (value.isEmpty))
                          ? "Invalid user ID."
                          : null,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Password",
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  onSaved: (input) => _password = input,
                  validator: (value) => ((value == null) || (value.isEmpty))
                      ? "Invalid password."
                      : null,
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
                      if ((_formKey.currentState == null) ||
                          (!_formKey.currentState!.validate())) {
                        return;
                      }

                      _formKey.currentState?.save();

                      try {
                        await bloc.signIn(SignInModel(
                          userId: _userId ?? "",
                          password: _password ?? "",
                        ));
                      } catch (exception) {
                        showSnackBar(context, treatException(exception));
                      }

                      // TODO if return success, "navigate" to camera
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
