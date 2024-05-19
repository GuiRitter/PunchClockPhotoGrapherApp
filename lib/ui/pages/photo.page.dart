import 'package:flutter/material.dart'
    show
        BackButton,
        BuildContext,
        Column,
        CrossAxisAlignment,
        EdgeInsets,
        ElevatedButton,
        Expanded,
        Padding,
        Placeholder,
        SizedBox,
        StatelessWidget,
        Text,
        Theme,
        Widget;
import 'package:flutter_redux/flutter_redux.dart' show StoreConnector;
import 'package:punch_clock_photo_grapher_app/common/common.import.dart'
    show StateEnum, l10n;
import 'package:punch_clock_photo_grapher_app/models/models.import.dart'
    show PhotoModel;
import 'package:punch_clock_photo_grapher_app/models/state.model.dart'
    show StateModel;
import 'package:punch_clock_photo_grapher_app/redux/main.reducer.dart'
    show getDispatch;
import 'package:punch_clock_photo_grapher_app/redux/navigation.action.dart'
    as navigation_action;
import 'package:punch_clock_photo_grapher_app/ui/widgets/widgets.import.dart'
    show AppBarSignedInWidget, BodyWidget, BottomAppBarWidget;

class PhotoPage extends StatelessWidget {
  const PhotoPage({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) =>
      StoreConnector<StateModel, PhotoModel>(
        distinct: true,
        converter: PhotoModel.select,
        builder: connectorBuilder,
      );

  Widget connectorBuilder(
    BuildContext context,
    PhotoModel photoModel,
  ) {
    final dispatch = getDispatch(
      context: context,
    );

    final theme = Theme.of(
      context,
    );

    final fieldPadding = theme.textTheme.labelLarge?.fontSize ?? 0.0;

    return BodyWidget(
      usePadding: false,
      appBar: AppBarSignedInWidget(
        appBarLeading: BackButton(
          onPressed: () => dispatch(
            navigation_action.go(
              state: StateEnum.list,
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                left: fieldPadding,
                right: fieldPadding,
                top: fieldPadding,
              ),
              child: Column(
                children: [
                  const Expanded(
                    child: Placeholder(),
                  ),
                  ElevatedButton(
                    onPressed: null,
                    child: Text(
                      photoModel.date,
                    ),
                  ),
                  SizedBox.square(
                    dimension: fieldPadding,
                  ),
                  ElevatedButton(
                    onPressed: null,
                    child: Text(
                      photoModel.time,
                    ),
                  ),
                ],
              ),
            ),
          ),
          BottomAppBarWidget(
            // TODO
            onButtonPressed: null,
            label: l10n.savePhoto,
          ),
        ],
      ),
    );
  }
}
