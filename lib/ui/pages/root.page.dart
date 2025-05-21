import 'package:flutter/material.dart'
    show BoxFit, BuildContext, MediaQuery, StatelessWidget, Widget;
import 'package:flutter_guiritter/model/model.import.dart' show InitModel;
import 'package:flutter_guiritter/ui/page/page.import.dart' show SplashPage;
import 'package:flutter_guiritter/util/util.import.dart' show logger;
import 'package:flutter_redux/flutter_redux.dart' show StoreConnector;
import 'package:flutter_svg/svg.dart' show SvgPicture;
import 'package:punch_clock_photo_grapher_app/common/common.import.dart'
    show AppLocalizations;
import 'package:punch_clock_photo_grapher_app/ui/pages/pages.import.dart';

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

    final mediaSize = MediaQuery.of(
      context,
    ).size;

    return initModel.isL10nLoaded
        ? TabsPage()
        : SplashPage(
            background: SvgPicture.asset(
              'asset/logo_background_texture.svg',
              semanticsLabel: 'logo background imitating wood',
              fit: BoxFit.fill,
              height: mediaSize.height,
              width: mediaSize.width,
            ),
            logo: SvgPicture.asset(
              'asset/logo.svg',
              semanticsLabel: 'logo representing a matrix of receipts',
            ),
          );
  }
}
