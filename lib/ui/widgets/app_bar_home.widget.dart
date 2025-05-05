import 'package:flutter/material.dart'
    show
        BuildContext,
        PreferredSizeWidget,
        Size,
        StatelessWidget,
        Widget,
        kToolbarHeight;
import 'package:flutter_guiritter/ui/widget/widget.import.dart'
    show AppBarSignedInWidget;
import 'package:punch_clock_photo_grapher_app/common/common.import.dart'
    show AppLocalizations;
import 'package:punch_clock_photo_grapher_app/models/models.import.dart'
    show StateModel;
import 'package:punch_clock_photo_grapher_app/ui/widgets/widgets.import.dart'
    show getTextL;

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
    return AppBarSignedInWidget<AppLocalizations, StateModel>(
      title: getTextL((l) => l!.title),
      // TODO
      // onHomePopupMenuItemPressedMap: {
      //   AppBarPopupMenuEnum.reload: (
      //     context,
      //   ) =>
      //       dispatch(
      //         data_action.getList(),
      //       ),
      // },
      // popupMenuItemList: [
      //   buildPopupMenuItem(
      //     l10nSelector: (l) => l!.reload,
      //     icon: Icons.replay,
      //     menuEnum: AppBarPopupMenuEnum.reload,
      //   ),
      // ],
    );
  }
}
