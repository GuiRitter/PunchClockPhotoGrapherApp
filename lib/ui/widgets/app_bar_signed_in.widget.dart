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
import 'package:punch_clock_photo_grapher_app/common/common.import.dart'
    show AppBarPopupMenuEnum, l10n;
import 'package:punch_clock_photo_grapher_app/redux/main.reducer.dart'
    show getDispatch;
import 'package:punch_clock_photo_grapher_app/redux/user.action.dart'
    as user_action;
import 'package:punch_clock_photo_grapher_app/ui/widgets/widgets.import.dart'
    show AppBarCustomWidget, buildPopupMenuItem;

class AppBarSignedInWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final Widget? appBarLeading;

  final Map<
      AppBarPopupMenuEnum,
      dynamic Function(
        BuildContext,
      )>? onHomePopupMenuItemPressedMap;

  final List<PopupMenuItem<AppBarPopupMenuEnum>>? popupMenuItemList;

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
    final dispatch = getDispatch(
      context: context,
    );

    final onHomePopupMenuItemPressedCompleteMap = <AppBarPopupMenuEnum,
        dynamic Function(
      BuildContext,
    )>{};

    if (onHomePopupMenuItemPressedMap != null) {
      onHomePopupMenuItemPressedCompleteMap.addAll(
        onHomePopupMenuItemPressedMap!,
      );
    }

    onHomePopupMenuItemPressedCompleteMap[AppBarPopupMenuEnum.signOut] = (
      context,
    ) {
      dispatch(
        user_action.signOut(),
      );
    };

    final popupMenuItemCompleteList = <PopupMenuItem<AppBarPopupMenuEnum>>[];

    if (popupMenuItemList != null) {
      popupMenuItemCompleteList.addAll(
        popupMenuItemList!,
      );
    }

    popupMenuItemCompleteList.add(buildPopupMenuItem(
      label: l10n.signOut,
      icon: Icons.logout,
      menuEnum: AppBarPopupMenuEnum.signOut,
    ));

    return AppBarCustomWidget(
      appBarLeading: appBarLeading,
      onHomePopupMenuItemPressedMap: onHomePopupMenuItemPressedCompleteMap,
      popupMenuItemList: popupMenuItemCompleteList,
    );
  }
}
