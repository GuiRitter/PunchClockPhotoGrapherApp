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
    return ElevatedButton(
      onPressed: null,
      child: Text(
        week.data,
      ),
    );
  }
}
