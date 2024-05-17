import 'package:flutter/material.dart'
    show
        BuildContext,
        kToolbarHeight,
        PreferredSizeWidget,
        Size,
        StatelessWidget,
        Widget;
import 'package:punch_clock_photo_grapher_app/ui/widgets/widgets.import.dart'
    show AppBarCustomWidget;

class AppBarSignedOutWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const AppBarSignedOutWidget({
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(
        kToolbarHeight,
      );

  @override
  Widget build(
    BuildContext context,
  ) =>
      const AppBarCustomWidget();
}
