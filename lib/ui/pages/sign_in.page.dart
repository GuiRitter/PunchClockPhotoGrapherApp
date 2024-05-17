import 'package:flutter/material.dart'
    show
        AutofillGroup,
        BuildContext,
        Column,
        EdgeInsets,
        ElevatedButton,
        Form,
        FormState,
        GlobalKey,
        InputDecoration,
        Padding,
        SingleChildScrollView,
        StatelessWidget,
        Text,
        TextEditingController,
        TextFormField,
        Theme,
        Widget;
import 'package:flutter/services.dart'
    show AutofillHints, TextInput, TextInputType;
import 'package:flutter_gen/gen_l10n/app_localizations.dart'
    show AppLocalizations;
import 'package:flutter_redux/flutter_redux.dart' show StoreConnector;
import 'package:punch_clock_photo_grapher_app/models/models.import.dart'
    show SignInModel, SignInRequestModel;
import 'package:punch_clock_photo_grapher_app/redux/main.reducer.dart'
    show getDispatch;
import 'package:punch_clock_photo_grapher_app/redux/user.action.dart'
    as user_action;
import 'package:punch_clock_photo_grapher_app/ui/widgets/widgets.import.dart'
    show AppBarSignedOutWidget, BodyWidget;
import 'package:punch_clock_photo_grapher_app/utils/utils.import.dart'
    show logger;

final _log = logger('SignInPage');

class SignInPage extends StatelessWidget {
  final userIdController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  SignInPage({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) =>
      StoreConnector(
        distinct: true,
        converter: SignInModel.select,
        builder: connectorBuilder,
      );

  Widget connectorBuilder(
    BuildContext context,
    SignInModel signInModel,
  ) {
    _log('connectorBuilder').map('signInModel', signInModel).print();

    var l10n = AppLocalizations.of(
      context,
    )!;

    onSignInPressed() => signIn(
          context: context,
        );

    buildTextFormField({
      required String autofillHint,
      required String labelText,
      required TextInputType keyboardType,
      bool obscureText = false,
      TextEditingController? controller,
      void Function(
        String?,
      )? onSaved,
      required String invalidMessage,
    }) =>
        TextFormField(
          autofillHints: [
            autofillHint,
          ],
          controller: controller,
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
          key: formKey,
          child: AutofillGroup(
            child: Column(
              children: [
                buildTextFormField(
                  autofillHint: AutofillHints.username,
                  labelText: l10n.userID,
                  keyboardType: TextInputType.text,
                  controller: userIdController,
                  invalidMessage: l10n.invalidUserID,
                ),
                buildTextFormField(
                  autofillHint: AutofillHints.password,
                  labelText: l10n.password,
                  keyboardType: TextInputType.visiblePassword,
                  controller: passwordController,
                  obscureText: true,
                  invalidMessage: l10n.invalidPassword,
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

  signIn({
    required BuildContext context,
  }) async {
    final dispatch = getDispatch(
      context: context,
    );

    _log('onSingInPressed').print();

    if (!(formKey.currentState?.validate() ?? false)) {
      return;
    }

    TextInput.finishAutofillContext();

    formKey.currentState?.save();

    var l10n = AppLocalizations.of(
      context,
    )!;

    dispatch(
      user_action.signIn(
        signInModel: SignInRequestModel(
          userId: userIdController.text,
          password: passwordController.text,
        ),
        l10n: l10n,
      ),
    );
  }
}
