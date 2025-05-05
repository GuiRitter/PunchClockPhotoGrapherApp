import 'package:flutter/material.dart'
    show BuildContext, StatelessWidget, Widget;
import 'package:flutter_guiritter/common/common.import.dart' show Settings;
import 'package:flutter_guiritter/redux/user/action.dart' as user_action;
import 'package:flutter_guiritter/util/util.import.dart' show logger;
import 'package:flutter_redux/flutter_redux.dart' show StoreConnector;
import 'package:punch_clock_photo_grapher_app/common/common.import.dart'
    show StateEnum;
import 'package:punch_clock_photo_grapher_app/models/models.import.dart'
    show StateModel, TabsModel;
import 'package:punch_clock_photo_grapher_app/redux/main.reducer.dart'
    show dispatch;
import 'package:punch_clock_photo_grapher_app/ui/pages/pages.import.dart'
    show HomePage, LoadingPage, PhotoPage, SignInPage;

final _log = logger('TabsPage');

class TabsPage extends StatelessWidget {
  const TabsPage({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    dispatch(
      user_action.validateAndSetToken(
        newToken: Settings.revalidateToken,
      ),
    );

    return StoreConnector<StateModel, TabsModel>(
      distinct: true,
      converter: TabsModel.select,
      builder: connectorBuilder,
    );
  }

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
