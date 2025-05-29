import 'package:flutter/material.dart' show TextAlign, TextStyle, Widget;
import 'package:flutter_guiritter/common/_import.dart' as common_guiritter
    show AppLocalizationsGuiRitter;
import 'package:flutter_guiritter/ui/widget/text_l10n.widget.dart'
    as widget_guiritter show TextL10n;
import 'package:punch_clock_photo_grapher_app/common/_import.dart'
    show AppLocalizations;

Widget getTextG(
  final String Function(
    common_guiritter.AppLocalizationsGuiRitter?,
  ) l10nGuiRitterSelector, {
  TextStyle? style,
  TextAlign? textAlign,
}) =>
    widget_guiritter.TextL10n<AppLocalizations>.g(
      l10nGuiRitterSelector,
      style: style,
    );

Widget getTextL(
  final String Function(
    AppLocalizations?,
  )? l10nSelector, {
  TextStyle? style,
  TextAlign? textAlign,
}) =>
    widget_guiritter.TextL10n<AppLocalizations>.l(
      l10nSelector,
      style: style,
    );
