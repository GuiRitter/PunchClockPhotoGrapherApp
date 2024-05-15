import 'package:flutter/material.dart'
    show BuildContext, StatelessWidget, Widget;
import 'package:flutter_redux/flutter_redux.dart' show StoreConnector;
import 'package:punch_clock_photo_grapher_app/common/state.enum.dart'
    show StateEnum;
import 'package:punch_clock_photo_grapher_app/models/state.model.dart'
    show StateModel;
import 'package:punch_clock_photo_grapher_app/models/tabs.model.dart'
    show TabsModel;
import 'package:punch_clock_photo_grapher_app/ui/pages/home.page.dart'
    show HomePage;
import 'package:punch_clock_photo_grapher_app/ui/pages/loading.page.dart'
    show LoadingPage;
import 'package:punch_clock_photo_grapher_app/ui/pages/photo.page.dart'
    show PhotoPage;
import 'package:punch_clock_photo_grapher_app/ui/pages/sign_in.page.dart'
    show SignInPage;
import 'package:punch_clock_photo_grapher_app/utils/logger.dart' show logger;

final _log = logger("TabsPage");

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
    _log("connectorBuilder").map("tabsModel", tabsModel).print();

    return tabsModel.isLoading
        ? const LoadingPage()
        : tabsModel.isSignedIn
            ? (tabsModel.state == StateEnum.photo)
                ? const PhotoPage()
                : const HomePage()
            : SignInPage();
  }
}
