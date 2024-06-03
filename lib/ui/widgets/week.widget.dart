import 'package:flutter/material.dart'
    show
        Axis,
        BuildContext,
        Column,
        CrossAxisAlignment,
        ElevatedButton,
        Icon,
        Icons,
        SizedBox,
        StatelessWidget,
        Text,
        Theme,
        Widget,
        Wrap,
        WrapCrossAlignment;
import 'package:punch_clock_photo_grapher_app/models/models.import.dart'
    show WeekModel;
import 'package:punch_clock_photo_grapher_app/ui/widgets/widgets.import.dart'
    show DateWidget;

class WeekWidget extends StatelessWidget {
  final WeekModel week;

  const WeekWidget({
    super.key,
    required this.week,
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox.square(
          dimension: halfFieldPadding,
        ),
        Wrap(
          direction: Axis.horizontal,
          spacing: halfFieldPadding,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              week.header,
            ),
            const ElevatedButton(
              // TODO
              onPressed: null,
              child: Icon(
                Icons.delete,
              ),
            ),
          ],
        ),
        ...week.dateList.map(
          (
            date,
          ) =>
              DateWidget(
            date: date,
          ),
        ),
        SizedBox.square(
          dimension: halfFieldPadding,
        ),
      ],
    );
  }
}
