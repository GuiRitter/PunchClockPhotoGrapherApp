import 'package:flutter/material.dart'
    show
        BuildContext,
        Icons,
        PreferredSizeWidget,
        Size,
        StatelessWidget,
        Widget,
        kToolbarHeight;
import 'package:flutter_guiritter/common/common.import.dart'
    as common_gui_ritter show AppLocalizationsGuiRitter, l10nGuiRitter;
import 'package:punch_clock_photo_grapher_app/common/common.import.dart'
    show AppBarPopupMenuEnum;
import 'package:punch_clock_photo_grapher_app/redux/data.action.dart'
    as data_action;
import 'package:punch_clock_photo_grapher_app/redux/main.reducer.dart'
    show getDispatch;
import 'package:punch_clock_photo_grapher_app/ui/widgets/widgets.import.dart'
    show AppBarSignedInWidget, buildPopupMenuItem;

common_gui_ritter.AppLocalizationsGuiRitter get l10nGuiRitter =>
    common_gui_ritter.l10nGuiRitter!;

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
          label: l10nGuiRitter.reload,
          icon: Icons.replay,
          menuEnum: AppBarPopupMenuEnum.reload,
        ),
      ],
    );
  }
}
