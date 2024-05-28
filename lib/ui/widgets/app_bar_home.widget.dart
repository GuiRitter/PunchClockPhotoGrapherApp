import 'package:flutter/material.dart'
    show
        BuildContext,
        Icons,
        PreferredSizeWidget,
        Size,
        StatelessWidget,
        Widget,
        kToolbarHeight;
import 'package:punch_clock_photo_grapher_app/common/common.import.dart'
    show AppBarPopupMenuEnum, l10n;
import 'package:punch_clock_photo_grapher_app/redux/data.action.dart'
    as data_action;
import 'package:punch_clock_photo_grapher_app/redux/main.reducer.dart'
    show getDispatch;
import 'package:punch_clock_photo_grapher_app/ui/widgets/widgets.import.dart'
    show AppBarSignedInWidget, buildPopupMenuItem;

class AppBarHomeWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarHomeWidget({
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(
        kToolbarHeight,
      );

  @override
  Widget build(
    BuildContext context,
  ) {
    final dispatch = getDispatch(
      context: context,
    );

    return AppBarSignedInWidget(
      onHomePopupMenuItemPressedMap: {
        AppBarPopupMenuEnum.reload: (
          context,
        ) =>
            dispatch(
              data_action.getList(),
            ),
      },
      popupMenuItemList: [
        buildPopupMenuItem(
          label: l10n.reload,
          icon: Icons.replay,
          menuEnum: AppBarPopupMenuEnum.reload,
        ),
      ],
    );
  }
}
