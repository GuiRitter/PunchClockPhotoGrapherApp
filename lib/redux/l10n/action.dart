import 'package:flutter_gen/gen_l10n/app_localizations.dart'
    show AppLocalizations;
import 'package:flutter_guiritter/common/common.import.dart'
    as common_gui_ritter show AppLocalizationsGuiRitter, l10nGuiRitter;
import 'package:punch_clock_photo_grapher_app/models/models.import.dart'
    show StateModel;
import 'package:redux/redux.dart' show Store;
import 'package:redux_thunk/redux_thunk.dart' show ThunkAction;

ThunkAction<StateModel> setL10n({
  required AppLocalizations? l10n,
  required common_gui_ritter.AppLocalizationsGuiRitter? l10nGuiRitter,
}) =>
    (
      Store<StateModel> store,
    ) async {
      common_gui_ritter.l10nGuiRitter = l10nGuiRitter;

      return store.dispatch(
        L10nAction(
          l10n: l10n,
          l10nGuiRitter: l10nGuiRitter,
        ),
      );
    };

class L10nAction {
  final AppLocalizations? l10n;
  final common_gui_ritter.AppLocalizationsGuiRitter? l10nGuiRitter;

  const L10nAction({
    required this.l10n,
    required this.l10nGuiRitter,
  });
}
