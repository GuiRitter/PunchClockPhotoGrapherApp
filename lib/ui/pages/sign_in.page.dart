import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:punch_clock_photo_grapher_app/common/settings.dart' as settings;
import 'package:punch_clock_photo_grapher_app/common/settings.dart';
import 'package:punch_clock_photo_grapher_app/models/sign_in.model.dart';
import 'package:punch_clock_photo_grapher_app/redux/main.reducer.dart';
import 'package:punch_clock_photo_grapher_app/redux/user.action.dart';
import 'package:punch_clock_photo_grapher_app/ui/widgets/app_bar_signed_out.widget.dart';
import 'package:punch_clock_photo_grapher_app/ui/widgets/body.widget.dart';
import 'package:punch_clock_photo_grapher_app/utils/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _log = logger("SignInPage");

// TODO transform to Stateless and use Redux (reused code for now)
class SignInPage extends StatefulWidget {
  const SignInPage({
    super.key,
  });

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();

  String? _userId;
  String? _password;

  @override
  Widget build(
    BuildContext context,
  ) {
    var l10n = AppLocalizations.of(
      context,
    )!;

    buildTextFormField({
      required String autofillHint,
      required String labelText,
      required TextInputType keyboardType,
      bool obscureText = false,
      required void Function(String?) onSaved,
      required String invalidMessage,
    }) =>
        TextFormField(
          autofillHints: [
            autofillHint,
          ],
          decoration: InputDecoration(
            labelText: labelText,
          ),
          keyboardType: keyboardType,
          obscureText: obscureText,
          onSaved: onSaved,
          validator: (
            value,
          ) =>
              (value?.isEmpty ?? true) ? invalidMessage : null,
        );

    setPassword(String? value) => _password = value;

    setUserId(String? value) => _userId = value;

    return BodyWidget(
      appBar: const AppBarSignedOutWidget(),
      body: SingleChildScrollView(
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
                buildTextFormField(
                  autofillHint: AutofillHints.username,
                  labelText: l10n.userID,
                  keyboardType: TextInputType.text,
                  invalidMessage: l10n.invalidUserID,
                  onSaved: setUserId,
                ),
                buildTextFormField(
                  autofillHint: AutofillHints.password,
                  labelText: l10n.password,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  invalidMessage: l10n.invalidPassword,
                  onSaved: setPassword,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: Theme.of(
                          context,
                        ).textTheme.titleLarge?.fontSize ??
                        0,
                  ),
                  child: ElevatedButton(
                    onPressed: onSignInPressed,
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
    );
  }

  @override
  void initState() {
    SharedPreferences.getInstance().then(
      (
        prefs,
      ) {
        var token = prefs.getString(
          settings.token,
        );

        _log("initState SharedPreferences.getInstance")
            .secret("token", token)
            .print();

        if (token?.isNotEmpty ?? false) {
          final context = navigatorState.currentContext!;

          final dispatch = getDispatch(
            context: context,
          );

          dispatch(
            validateAndSetToken(
              newToken: token,
            ),
          );
        }
      },
    );

    super.initState();
  }

  onSignInPressed() async {
    final dispatch = getDispatch(
      context: context,
    );

    _log("onSingInPressed").print();

    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    TextInput.finishAutofillContext();

    _formKey.currentState?.save();

    //

    dispatch(
      signIn(
        signInModel: SignInModel(
          userId: _userId!,
          password: _password!,
        ),
      ),
    );

    // TODO
    // if (result.hasMessageNotIn(
    //   status: ResultStatus.success,
    // )) {
    //   showSnackBar(
    //     message: result.message,
    //   );
    // } else {
    //   dataBloc.revalidateData(
    //     refreshBaseData: true,
    //   );
    // }
  }
}
