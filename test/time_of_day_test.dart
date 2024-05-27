import 'package:flutter/material.dart' show TimeOfDay;
import 'package:flutter_test/flutter_test.dart' show expect, test;
import 'package:punch_clock_photo_grapher_app/utils/utils.import.dart'
    show TimeOfDayNullableExtension;

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
        a.getISO8601Time(),
        '02:03',
      );
    },
  );
}
