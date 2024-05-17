import 'package:flutter/material.dart'
    show
        Axis,
        BuildContext,
        StatelessWidget,
        Text,
        Theme,
        Widget,
        Wrap,
        WrapCrossAlignment;
import 'package:punch_clock_photo_grapher_app/models/models.import.dart'
    show DateModel;
import 'package:punch_clock_photo_grapher_app/ui/widgets/widgets.import.dart'
    show TimeWidget;

class DateWidget extends StatelessWidget {
  final DateModel date;

  const DateWidget({
    super.key,
    required this.date,
  });

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
          date.weekDay,
        ),
        ...date.timeList.map(
          (
            time,
          ) =>
              TimeWidget(
            dateTime: time,
          ),
        )
      ],
    );
  }
}
