import 'package:flutter/material.dart'
    show
        BuildContext,
        Icons,
        kToolbarHeight,
        PreferredSizeWidget,
        Size,
        StatelessWidget,
        Widget;
import 'package:punch_clock_photo_grapher_app/common/common.import.dart'
    show AppBarPopupMenuEnum, l10n;
import 'package:punch_clock_photo_grapher_app/redux/data.action.dart'
    as data_action;
import 'package:punch_clock_photo_grapher_app/redux/main.reducer.dart'
    show getDispatch;
import 'package:punch_clock_photo_grapher_app/redux/user.action.dart'
    as user_action;
import 'package:punch_clock_photo_grapher_app/ui/widgets/widgets.import.dart'
    show AppBarCustomWidget, buildPopupMenuItem;

// TODO should not have reload at photo page

class AppBarSignedInWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final Widget? appBarLeading;

  const AppBarSignedInWidget({
    super.key,
    this.appBarLeading,
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

    return AppBarCustomWidget(
      appBarLeading: appBarLeading,
      onHomePopupMenuItemPressedMap: {
        AppBarPopupMenuEnum.reload: (
          context,
        ) =>
            dispatch(
              data_action.getList(),
            ),
        AppBarPopupMenuEnum.signOut: (
          context,
        ) {
          dispatch(
            user_action.signOut(),
          );
        },
      },
      popupMenuItemList: [
        buildPopupMenuItem(
          label: l10n.reload,
          icon: Icons.replay,
          menuEnum: AppBarPopupMenuEnum.reload,
        ),
        buildPopupMenuItem(
          label: l10n.signOut,
          icon: Icons.logout,
          menuEnum: AppBarPopupMenuEnum.signOut,
        ),
      ],
    );
  }
}
