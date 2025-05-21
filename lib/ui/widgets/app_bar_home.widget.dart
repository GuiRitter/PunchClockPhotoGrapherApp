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
import 'package:flutter_guiritter/redux/redux.import.dart' show dispatch;
import 'package:flutter_guiritter/ui/widget/widget.import.dart'
    show AppBarSignedInWidget;
import 'package:flutter_guiritter/util/util.import.dart'
    show buildPopupMenuItem;
import 'package:punch_clock_photo_grapher_app/common/common.import.dart'
    show AppBarPopupMenuEnum, AppLocalizations;
import 'package:punch_clock_photo_grapher_app/redux/data/action.dart'
    as data_action;
import 'package:punch_clock_photo_grapher_app/ui/widgets/widgets.import.dart'
    show getTextG, getTextL;

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
  ) =>
      AppBarSignedInWidget<AppLocalizations>(
        title: getTextL((l) => l!.title),
        onHomePopupMenuItemPressedMap: {
          AppBarPopupMenuEnum.reload.name: (
            context,
          ) =>
              dispatch(
                data_action.getList(),
              ),
        },
        popupMenuItemBuilder: ({
          required List<PopupMenuItem<String>> popupMenuItemList,
        }) =>
            [
          buildPopupMenuItem(
            titleWidget: getTextG((l) => l!.reload),
            icon: Icons.replay,
            value: AppBarPopupMenuEnum.reload,
          ),
          ...popupMenuItemList,
        ],
      );
}
