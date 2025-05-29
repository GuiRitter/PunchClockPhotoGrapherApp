import 'package:flutter/material.dart'
    show
        BuildContext,
        Column,
        CrossAxisAlignment,
        MediaQuery,
        SizedBox,
        StatelessWidget,
        Widget;
import 'package:flutter_guiritter/redux/_import.dart' show dispatch;
import 'package:flutter_guiritter/ui/widget/_import.dart'
    show BodyWidget, BottomAppBarWidget;
import 'package:flutter_guiritter/util/_import.dart' show logger;
import 'package:flutter_redux/flutter_redux.dart' show StoreConnector;
import 'package:punch_clock_photo_grapher_app/common/_import.dart'
    show StateEnum;
import 'package:punch_clock_photo_grapher_app/model/_import.dart'
    show ListModel;
import 'package:punch_clock_photo_grapher_app/redux/navigation/action.dart'
    as navigation_action;
import 'package:punch_clock_photo_grapher_app/ui/widget/_import.dart'
    show AppBarHomeWidget, getTextL, HomeWidget;

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
      body: StoreConnector<Map<String, dynamic>, ListModel?>(
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
            label: getTextL((l) => l!.takePhoto),
          ),
        ],
      ),
    );
  }

  goToPhotoPage({
    required BuildContext context,
  }) {
    _log('goToPhotoPage').print();

    dispatch(
      navigation_action.go(
        state: StateEnum.photo,
      ),
    );
  }
}
