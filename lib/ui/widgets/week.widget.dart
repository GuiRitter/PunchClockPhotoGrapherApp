import 'package:flutter/material.dart';
import 'package:punch_clock_photo_grapher_app/models/week.model.dart';
import 'package:punch_clock_photo_grapher_app/ui/widgets/date.widget.dart';

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
      children: [
        Wrap(
          direction: Axis.horizontal,
          spacing: halfFieldPadding,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              "${week.number}",
            ),
            const ElevatedButton(
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
      ],
    );
  }
}
