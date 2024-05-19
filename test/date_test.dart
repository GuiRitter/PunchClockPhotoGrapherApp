import 'package:flutter_test/flutter_test.dart' show expect, test;
import 'package:intl/intl.dart' show DateFormat;

void main() {
  test(
    'format',
    () async {
      expect(
        DateFormat(
          'y-MM-dd',
        ).format(
          DateTime(
            2024,
            1,
            1,
          ),
        ),
        '2024-01-01',
      );
    },
  );
}
