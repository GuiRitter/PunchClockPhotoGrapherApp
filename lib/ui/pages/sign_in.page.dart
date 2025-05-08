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
        Padding,
        SingleChildScrollView,
        StatelessWidget,
        TextEditingController,
        Theme,
        Widget;
import 'package:flutter/services.dart'
    show AutofillHints, TextInput, TextInputType;
import 'package:flutter_guiritter/model/model.import.dart'
    show SignInModel, SignInRequestModel;
import 'package:flutter_guiritter/redux/redux.import.dart' show dispatch;
import 'package:flutter_guiritter/redux/user/action.dart' as user_action;
import 'package:flutter_guiritter/ui/widget/widget.import.dart'
    show AppBarSignedOutWidget, TextFormFieldL10n;
import 'package:flutter_guiritter/util/util.import.dart' show logger;
import 'package:flutter_redux/flutter_redux.dart' show StoreConnector;
import 'package:punch_clock_photo_grapher_app/common/common.import.dart'
    show AppLocalizations;
import 'package:punch_clock_photo_grapher_app/model/model.import.dart'
    show StateModel;
import 'package:punch_clock_photo_grapher_app/ui/widgets/widgets.import.dart'
    show BodyWidget, getTextG, getTextL;

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
      StoreConnector<StateModel, SignInModel<AppLocalizations, StateModel>>(
        distinct: true,
        converter: SignInModel.select,
        builder: connectorBuilder,
      );

  Widget connectorBuilder(
    BuildContext context,
    SignInModel<AppLocalizations, StateModel> signInModel,
  ) {
    _log('connectorBuilder').map('signInModel', signInModel).print();

    onSignInPressed() => signIn(
          context: context,
        );

    return BodyWidget(
      appBar: AppBarSignedOutWidget<AppLocalizations, StateModel>(
        title: getTextL((l) => l!.title),
      ),
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
                TextFormFieldL10n<AppLocalizations, StateModel>(
                  autofillHint: AutofillHints.username,
                  controller: userIdController,
                  invalidMessageL10nGuiRitter: (l) => l!.invalidUserID,
                  keyboardType: TextInputType.text,
                  labelL10nGuiRitter: (l) => l!.userID,
                ),
                TextFormFieldL10n<AppLocalizations, StateModel>(
                  autofillHint: AutofillHints.password,
                  controller: passwordController,
                  invalidMessageL10nGuiRitter: (l) => l!.invalidPassword,
                  keyboardType: TextInputType.visiblePassword,
                  labelL10nGuiRitter: (l) => l!.password,
                  obscureText: true,
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
                    child: getTextG(
                      (l) => l!.signIn,
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
    _log('onSingInPressed').print();

    if (!(formKey.currentState?.validate() ?? false)) {
      return;
    }

    TextInput.finishAutofillContext();

    formKey.currentState?.save();

    dispatch(
      user_action.signIn(
        signInModel: SignInRequestModel(
          userId: userIdController.text,
          password: passwordController.text,
        ),
      ),
    );
  }
}
