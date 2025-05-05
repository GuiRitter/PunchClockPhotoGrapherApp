import 'package:flutter/material.dart'
    show BuildContext, StatelessWidget, Widget;
import 'package:flutter_redux/flutter_redux.dart' show StoreConnector;
import 'package:punch_clock_photo_grapher_app/models/models.import.dart'
    show InitModel, StateModel;
import 'package:punch_clock_photo_grapher_app/ui/pages/pages.import.dart'
    show SplashPage, TabsPage;
import 'package:punch_clock_photo_grapher_app/utils/utils.import.dart'
    show logger;

final _log = logger('RootPage');

class RootPage extends StatelessWidget {
  const RootPage({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) =>
      StoreConnector<StateModel, InitModel>(
        distinct: true,
        converter: InitModel.select,
        builder: connectorBuilder,
      );

  Widget connectorBuilder(
    BuildContext context,
    InitModel initModel,
  ) {
    _log('connectorBuilder').map('initModel', initModel).print();

    return initModel.isL10nLoaded ? TabsPage() : const SplashPage();
  }
}
