import 'package:flutter/material.dart'
    show
        BuildContext,
        Icons,
        PopupMenuItem,
        PreferredSizeWidget,
        Size,
        StatelessWidget,
        Widget,
        kToolbarHeight;
import 'package:flutter_guiritter/redux/user/action.dart' as user_action;
import 'package:punch_clock_photo_grapher_app/common/common.import.dart'
    show OldAppBarPopupMenuEnum;
import 'package:punch_clock_photo_grapher_app/redux/main.reducer.dart'
    show dispatch;
import 'package:punch_clock_photo_grapher_app/ui/widgets/widgets.import.dart'
    show AppBarCustomWidget, buildPopupMenuItem;

class AppBarSignedInWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final Widget? appBarLeading;

  final Map<
      OldAppBarPopupMenuEnum,
      dynamic Function(
        BuildContext,
      )>? onHomePopupMenuItemPressedMap;

  final List<PopupMenuItem<OldAppBarPopupMenuEnum>>? popupMenuItemList;

  const AppBarSignedInWidget({
    super.key,
    this.appBarLeading,
    this.onHomePopupMenuItemPressedMap,
    this.popupMenuItemList,
  });

  @override
  Size get preferredSize => const Size.fromHeight(
        kToolbarHeight,
      );

  @override
  Widget build(
    BuildContext context,
  ) {
    final onHomePopupMenuItemPressedCompleteMap = <OldAppBarPopupMenuEnum,
        dynamic Function(
      BuildContext,
    )>{};

    if (onHomePopupMenuItemPressedMap != null) {
      onHomePopupMenuItemPressedCompleteMap.addAll(
        onHomePopupMenuItemPressedMap!,
      );
    }

    onHomePopupMenuItemPressedCompleteMap[OldAppBarPopupMenuEnum.signOut] = (
      context,
    ) {
      dispatch(
        user_action.signOut(),
      );
    };

    final popupMenuItemCompleteList = <PopupMenuItem<OldAppBarPopupMenuEnum>>[];

    if (popupMenuItemList != null) {
      popupMenuItemCompleteList.addAll(
        popupMenuItemList!,
      );
    }

    popupMenuItemCompleteList.add(
      buildPopupMenuItem(
        l10nSelector: (l) => l!.signOut,
        icon: Icons.logout,
        menuEnum: OldAppBarPopupMenuEnum.signOut,
      ),
    );

    return AppBarCustomWidget(
      appBarLeading: appBarLeading,
      onHomePopupMenuItemPressedMap: onHomePopupMenuItemPressedCompleteMap,
      popupMenuItemList: popupMenuItemCompleteList,
    );
  }
}
