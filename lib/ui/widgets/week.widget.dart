import 'package:flutter/material.dart';
import 'package:punch_clock_photo_grapher_app/models/week.model.dart';

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
    final children = [
      Row(
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
            Text(
          date,
        ),
      ),
    ];

    return Column(
      children: children,
    );
  }
}
