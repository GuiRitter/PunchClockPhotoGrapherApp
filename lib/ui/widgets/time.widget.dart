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

class TimeWidget extends StatelessWidget {
  final DateTime dateTime;

  TimeWidget({
    super.key,
    required String dateTime,
  }) : dateTime = DateTime.parse(
          dateTime,
        );

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
          DateFormat.Hm().format(
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
