import 'package:flutter/material.dart'
    show BuildContext, StatelessWidget, Widget;
import 'package:flutter_redux/flutter_redux.dart' show StoreConnector;
import 'package:punch_clock_photo_grapher_app/common/common.import.dart'
    show StateEnum;
import 'package:punch_clock_photo_grapher_app/models/models.import.dart'
    show StateModel, TabsModel;
import 'package:punch_clock_photo_grapher_app/ui/pages/pages.import.dart'
    show LoadingPage, HomePage, PhotoPage, SignInPage;
import 'package:punch_clock_photo_grapher_app/utils/utils.import.dart'
    show logger;

final _log = logger('TabsPage');

class TabsPage extends StatelessWidget {
  const TabsPage({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) =>
      StoreConnector<StateModel, TabsModel>(
        distinct: true,
        converter: TabsModel.select,
        builder: connectorBuilder,
      );

  Widget connectorBuilder(
    BuildContext context,
    TabsModel tabsModel,
  ) {
    _log('connectorBuilder').map('tabsModel', tabsModel).print();

    return tabsModel.isLoading
        ? const LoadingPage()
        : tabsModel.isSignedIn
            ? (tabsModel.state == StateEnum.photo)
                ? const PhotoPage()
                : const HomePage()
            : SignInPage();
  }
}
