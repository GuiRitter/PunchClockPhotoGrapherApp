import 'package:flutter/material.dart'
    show
        AlertDialog,
        AnnotatedRegion,
        AppBar,
        BuildContext,
        Column,
        CrossAxisAlignment,
        GlobalKey,
        Icon,
        IconData,
        Icons,
        kToolbarHeight,
        ListTile,
        MainAxisSize,
        Material,
        PopupMenuButton,
        PopupMenuEntry,
        PopupMenuItem,
        PreferredSizeWidget,
        Semantics,
        showDialog,
        SingleChildRenderObjectElement,
        StatefulElement,
        StatelessWidget,
        Text,
        TextButton,
        Theme,
        ThemeMode,
        Widget;
import 'package:flutter/services.dart'
    show Size, SystemUiOverlayStyle, TextAlign;
import 'package:flutter_gen/gen_l10n/app_localizations.dart'
    show AppLocalizations;
import 'package:punch_clock_photo_grapher_app/common/common.import.dart'
    show AppBarPopupMenuEnum, navigatorState;
import 'package:punch_clock_photo_grapher_app/ui/widgets/widgets.import.dart'
    show ThemeOptionWidget;
import 'package:punch_clock_photo_grapher_app/utils/utils.import.dart'
    show logger, onDialogCancelPressed;

double? appBarElevation;

final GlobalKey appBarKey = GlobalKey();

final _log = logger('appBarCustom');

PopupMenuItem<AppBarPopupMenuEnum> buildPopupMenuItem({
  required String label,
  required IconData icon,
  required AppBarPopupMenuEnum menuEnum,
}) =>
    PopupMenuItem<AppBarPopupMenuEnum>(
      value: menuEnum,
      child: ListTile(
        leading: Icon(
          icon,
        ),
        title: Text(
          label,
        ),
      ),
    );

Future<double> getAppBarElevation({
  required int delay,
}) async {
  _log('getAppBarElevation').raw('delay', delay).print();

  if (appBarElevation != null) {
    return appBarElevation!;
  }

  await Future.delayed(
    Duration(
      microseconds: delay,
    ),
  );

  final BuildContext? context = appBarKey.currentContext;

  if (context != null) {
    final statefulElement = context as StatefulElement;

    SingleChildRenderObjectElement? singleChildRenderObjectElement;

    statefulElement.visitChildElements(
      (
        element,
      ) {
        singleChildRenderObjectElement =
            element as SingleChildRenderObjectElement;
      },
    );

    final semantics = singleChildRenderObjectElement!.widget as Semantics;

    final annotatedRegion = semantics.child as AnnotatedRegion;

    final material = annotatedRegion.child as Material;

    appBarElevation = material.elevation;

    return appBarElevation!;
  } else {
    return await getAppBarElevation(
      delay: delay + 1,
    );
  }
}

String? _getSubtitle() {
  return null;
}

class AppBarCustomWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final Widget? appBarLeading;

  final Map<
      AppBarPopupMenuEnum,
      dynamic Function(
        BuildContext,
      )>? onHomePopupMenuItemPressedMap;

  final List<PopupMenuItem<AppBarPopupMenuEnum>>? popupMenuItemList;

  const AppBarCustomWidget({
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
    final context = navigatorState.currentContext!;

    final theme = Theme.of(
      context,
    );

    final l10n = AppLocalizations.of(
      context,
    )!;

    final String? subtitle = _getSubtitle();

    final title = (subtitle == null)
        ? Text(
            l10n.title,
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                l10n.title,
                style: theme.textTheme.bodySmall!.copyWith(
                  color: theme.colorScheme.onPrimary,
                ),
              ),
              Text(
                subtitle,
              ),
            ],
          );

    final popupMenuItemCompleteList = <PopupMenuEntry<AppBarPopupMenuEnum>>[];

    if (popupMenuItemList != null) {
      popupMenuItemCompleteList.addAll(
        popupMenuItemList!,
      );
    }

    popupMenuItemCompleteList.add(
      buildPopupMenuItem(
        label: l10n.appTheme,
        icon: Icons.color_lens,
        menuEnum: AppBarPopupMenuEnum.theme,
      ),
    );

    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      key: appBarKey,
      title: title,
      leading: appBarLeading,
      actions: [
        PopupMenuButton<AppBarPopupMenuEnum>(
          itemBuilder: (
            context,
          ) =>
              popupMenuItemCompleteList,
          onSelected: (
            value,
          ) =>
              _onHomePopupMenuItemPressed(
            context: context,
            value: value,
          ),
        ),
      ],
    );
  }

  _onHomePopupMenuItemPressed({
    required BuildContext context,
    required AppBarPopupMenuEnum value,
  }) {
    _log('onHomePopupMenuItemPressed').enum_('value', value).print();

    final l10n = AppLocalizations.of(
      context,
    )!;

    final onHomePopupMenuItemPressedCompleteMap = <AppBarPopupMenuEnum,
        dynamic Function(
      BuildContext,
    )>{};

    if (onHomePopupMenuItemPressedMap != null) {
      onHomePopupMenuItemPressedCompleteMap.addAll(
        onHomePopupMenuItemPressedMap!,
      );
    }

    onHomePopupMenuItemPressedCompleteMap[AppBarPopupMenuEnum.theme] = (
      BuildContext context,
    ) =>
        showDialog(
          context: context,
          builder: (
            context,
          ) {
            final optionList = [
              ThemeOptionWidget(
                themeMode: ThemeMode.dark,
                title: l10n.darkTheme,
              ),
              ThemeOptionWidget(
                themeMode: ThemeMode.light,
                title: l10n.lightTheme,
              ),
              ThemeOptionWidget(
                themeMode: ThemeMode.system,
                title: l10n.systemTheme,
              ),
            ];

            return AlertDialog(
              title: Text(
                l10n.chooseTheme,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: optionList,
              ),
              actions: [
                TextButton(
                  onPressed: () => onDialogCancelPressed(
                    context: context,
                  ),
                  child: Text(
                    l10n.cancel,
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            );
          },
        );

    onHomePopupMenuItemPressedCompleteMap[value]!(
      context,
    );
  }
}
