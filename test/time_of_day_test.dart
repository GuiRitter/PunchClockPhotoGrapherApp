import 'package:flutter/material.dart' show TimeOfDay;
import 'package:flutter_test/flutter_test.dart' show expect, test;
import 'package:punch_clock_photo_grapher_app/utils/utils.import.dart'
    show getISO8601TimeFromTimeOfDay;

void main() {
  test(
    'compare',
    () async {
      const a = TimeOfDay(
        hour: 2,
        minute: 3,
      );

      const b = TimeOfDay(
        hour: 2,
        minute: 3,
      );

      expect(
        a == b,
        true,
      );

      expect(
        getISO8601TimeFromTimeOfDay(
          timeOfDay: a,
        ),
        '02:03',
      );
    },
  );
}
