import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:punch_clock_photo_grapher_app/models/state.model.dart';
import 'package:punch_clock_photo_grapher_app/models/tabs.model.dart';
import 'package:punch_clock_photo_grapher_app/ui/pages/home.page.dart';
import 'package:punch_clock_photo_grapher_app/ui/pages/loading.page.dart';
import 'package:punch_clock_photo_grapher_app/ui/pages/sign_in.page.dart';

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
        converter: StateModel.selectTabsModel,
        builder: connectorBuilder,
      );

  Widget connectorBuilder(
    BuildContext context,
    TabsModel tabsModel,
  ) =>
      tabsModel.isLoading
          ? const LoadingPage()
          : tabsModel.isSignedIn
              ? const HomePage()
              : const SignInPage();
}
