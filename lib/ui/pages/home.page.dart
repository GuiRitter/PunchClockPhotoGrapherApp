import 'package:flutter/material.dart'
    show
        BuildContext,
        Column,
        CrossAxisAlignment,
        MediaQuery,
        SizedBox,
        StatelessWidget,
        Widget;
import 'package:flutter_redux/flutter_redux.dart' show StoreConnector;
import 'package:punch_clock_photo_grapher_app/common/common.import.dart'
    show l10n, StateEnum;
import 'package:punch_clock_photo_grapher_app/models/models.import.dart'
    show ListModel, StateModel;
import 'package:punch_clock_photo_grapher_app/redux/main.reducer.dart'
    show getDispatch;
import 'package:punch_clock_photo_grapher_app/redux/navigation.action.dart'
    as navigation_action;
import 'package:punch_clock_photo_grapher_app/ui/widgets/widgets.import.dart'
    show AppBarHomeWidget, BodyWidget, BottomAppBarWidget, HomeWidget;
import 'package:punch_clock_photo_grapher_app/utils/utils.import.dart'
    show logger;

final _log = logger('HomePage');

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    _log('build').print();

    return BodyWidget(
      usePadding: false,
      appBar: const AppBarHomeWidget(),
      body: StoreConnector<StateModel, ListModel?>(
        distinct: true,
        converter: ListModel.select,
        builder: connectorBuilder,
      ),
    );
  }

  Widget connectorBuilder(
    BuildContext context,
    ListModel? model,
  ) {
    _log('connectorBuilder').map('list', model).print();

    final mediaSize = MediaQuery.of(
      context,
    ).size;

    onPhotoButtonPressed() => goToPhotoPage(
          context: context,
        );

    return SizedBox(
      height: mediaSize.height,
      width: mediaSize.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          HomeWidget(
            model: model,
          ),
          BottomAppBarWidget(
            onButtonPressed: onPhotoButtonPressed,
            label: l10n.takePhoto,
          ),
        ],
      ),
    );
  }

  goToPhotoPage({
    required BuildContext context,
  }) {
    final dispatch = getDispatch(
      context: context,
    );

    dispatch(
      navigation_action.go(
        state: StateEnum.photo,
      ),
    );
  }
}
