import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:punch_clock_photo_grapher_app/common/app_bar_popup_menu.enum.dart';
import 'package:punch_clock_photo_grapher_app/redux/main.reducer.dart';
import 'package:punch_clock_photo_grapher_app/redux/user.action.dart';
import 'package:punch_clock_photo_grapher_app/ui/widgets/app_bar_custom.widget.dart';

class AppBarSignedInWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const AppBarSignedInWidget({
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
    final l10n = AppLocalizations.of(
      context,
    )!;

    return AppBarCustomWidget(
      onHomePopupMenuItemPressedMap: {
        AppBarPopupMenuEnum.reload: (
          context,
        ) {
          // TODO
        },
        AppBarPopupMenuEnum.signOut: (
          context,
        ) {
          final dispatch = getDispatch(
            context: context,
          );

          dispatch(
            signOut(),
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
