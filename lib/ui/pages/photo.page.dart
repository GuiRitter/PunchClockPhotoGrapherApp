import 'package:flutter/material.dart'
    show BackButton, BuildContext, StatelessWidget, Text, Widget;
import 'package:punch_clock_photo_grapher_app/common/state.enum.dart';
import 'package:punch_clock_photo_grapher_app/redux/main.reducer.dart'
    show getDispatch;
import 'package:punch_clock_photo_grapher_app/redux/navigation.action.dart'
    show navigate;
import 'package:punch_clock_photo_grapher_app/ui/widgets/app_bar_signed_in.widget.dart'
    show AppBarSignedInWidget;
import 'package:punch_clock_photo_grapher_app/ui/widgets/body.widget.dart'
    show BodyWidget;

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
            navigate(
              state: StateEnum.list,
            ),
          ),
        ),
      ),
      body: const Text(
        "Photo Page",
      ),
    );
  }
}
