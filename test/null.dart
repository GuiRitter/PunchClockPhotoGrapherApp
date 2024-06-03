import 'package:flutter/material.dart' show ValueGetter;
import 'package:flutter_test/flutter_test.dart' show expect, test;

ValueGetter<String?>? getNullValue() => () => null;
ValueGetter<String?>? getNullGetter() => null;

void main() {
  test('third option', () async {
    ValueGetter<String?>? nullValue = getNullValue();
    ValueGetter<String?>? nullGetter = getNullGetter();

    expect(
      nullGetter?.call() ?? 'other',
      'other',
    );

    // I think it should be null
    expect(
      nullValue?.call() ?? 'other',
      // null,
      'other',
    );
  });
}
