import 'package:flutter/material.dart'
    show
        BackButton,
        BuildContext,
        Column,
        CrossAxisAlignment,
        Expanded,
        Placeholder,
        StatelessWidget,
        Widget;
import 'package:punch_clock_photo_grapher_app/common/common.import.dart'
    show StateEnum, l10n;
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
  ) {
    final dispatch = getDispatch(
      context: context,
    );

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
          const Expanded(
            child: Placeholder(),
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
