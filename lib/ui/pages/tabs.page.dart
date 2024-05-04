import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:punch_clock_photo_grapher_app/models/state.model.dart';
import 'package:punch_clock_photo_grapher_app/models/tabs.model.dart';
import 'package:punch_clock_photo_grapher_app/ui/pages/home.page.dart';
import 'package:punch_clock_photo_grapher_app/ui/pages/loading.page.dart';
import 'package:punch_clock_photo_grapher_app/ui/pages/sign_in.page.dart';
import 'package:punch_clock_photo_grapher_app/utils/logger.dart';

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
            ? const HomePage()
            : SignInPage();
  }
}
