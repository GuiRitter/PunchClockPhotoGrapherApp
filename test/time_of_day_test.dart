import 'package:flutter/material.dart' show TimeOfDay;
import 'package:flutter_guiritter/extension/_import.dart'
    show TimeOfDayNullableExtension;
import 'package:flutter_test/flutter_test.dart' show expect, test;

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
