import 'package:flutter/material.dart';
import 'package:punch_clock_photo_grapher_app/ui/widgets/app_bar_custom.widget.dart';

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
