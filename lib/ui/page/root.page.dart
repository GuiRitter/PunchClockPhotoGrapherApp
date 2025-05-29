import 'package:flutter/material.dart'
    show BuildContext, StatelessWidget, Widget;
import 'package:flutter_guiritter/model/_import.dart' show InitModel;
import 'package:flutter_guiritter/ui/page/_import.dart' show SplashPage;
import 'package:flutter_guiritter/util/_import.dart' show logger;
import 'package:flutter_redux/flutter_redux.dart' show StoreConnector;
import 'package:punch_clock_photo_grapher_app/common/_import.dart'
    show AppLocalizations;
import 'package:punch_clock_photo_grapher_app/ui/page/_import.dart'
    show TabsPage;

final _log = logger('RootPage');

class RootPage extends StatelessWidget {
  const RootPage({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) =>
      StoreConnector<Map<String, dynamic>, InitModel<AppLocalizations>>(
        distinct: true,
        converter: InitModel.select,
        builder: connectorBuilder,
      );

  Widget connectorBuilder(
    BuildContext context,
    InitModel<AppLocalizations> initModel,
  ) {
    _log('connectorBuilder').map('initModel', initModel).print();

    return initModel.isL10nLoaded
        ? TabsPage()
        : SplashPage(
            backgroundAssetName: 'asset/logo_background_texture.svg',
            backgroundSemanticsLabel: 'logo background imitating wood',
            logoAssetName: 'asset/logo.svg',
            logoSemanticsLabel: 'logo representing a matrix of receipts',
          );
  }
}
