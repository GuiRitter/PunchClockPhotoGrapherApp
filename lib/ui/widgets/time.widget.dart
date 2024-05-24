import 'package:flutter/material.dart'
    show
        Axis,
        BuildContext,
        ElevatedButton,
        Icon,
        Icons,
        StatelessWidget,
        Text,
        Theme,
        Widget,
        Wrap,
        WrapCrossAlignment;
import 'package:intl/intl.dart';
import 'package:punch_clock_photo_grapher_app/common/common.import.dart'
    show Settings;

class TimeWidget extends StatelessWidget {
  final DateTime dateTime;

  TimeWidget({
    super.key,
    required String dateTime,
  }) : dateTime = DateTime.parse(
          dateTime,
        ).toLocal();

  @override
  Widget build(
    BuildContext context,
  ) {
    final theme = Theme.of(
      context,
    );

    final fieldPadding = theme.textTheme.labelLarge?.fontSize ?? 0.0;
    final halfFieldPadding = fieldPadding / 2;

    return Wrap(
      direction: Axis.horizontal,
      spacing: halfFieldPadding,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
          DateFormat.Hm(
            Settings.locale,
          ).format(
            dateTime,
          ),
        ),
        const ElevatedButton(
          onPressed: null,
          child: Icon(
            Icons.delete,
          ),
        ),
      ],
    );
  }
}
