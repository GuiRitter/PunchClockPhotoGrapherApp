import 'package:flutter_gen/gen_l10n/app_localizations.dart'
    show AppLocalizations;
import 'package:flutter_guiritter/common/common.import.dart'
    as common_gui_ritter show AppLocalizationsGuiRitter;
import 'package:punch_clock_photo_grapher_app/models/models.import.dart'
    show LoggableModel, StateModel;
import 'package:redux/redux.dart' show Store;

class L10nModel implements LoggableModel {
  final common_gui_ritter.AppLocalizationsGuiRitter? l10nGuiRitter;
  final AppLocalizations? l10n;

  L10nModel({
    required this.l10nGuiRitter,
    required this.l10n,
  });

  @override
  int get hashCode => Object.hash(
        l10nGuiRitter,
        l10n,
      );

  @override
  bool operator ==(
    Object other,
  ) {
    if (other is! L10nModel) {
      return false;
    }
    return (l10nGuiRitter == other.l10nGuiRitter) && (l10n == other.l10n);
  }

  @override
  Map<String, dynamic> asLog() => <String, dynamic>{
        'isSignedIn': l10nGuiRitter,
        'state': l10n,
      };

  static L10nModel select(
    Store<StateModel> store,
  ) =>
      L10nModel(
        l10nGuiRitter: store.state.l10nGuiRitter,
        l10n: store.state.l10n,
      );
}
