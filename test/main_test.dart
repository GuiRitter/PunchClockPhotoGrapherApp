import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:punch_clock_photo_grapher_mobile/main.dart';

void main() {
  test('should return TimeOfDay', () {
    var result = buildTimeOfDay(
      "12:34",
    );

    expect(
      result,
      const TimeOfDay(
        hour: 12,
        minute: 34,
      ),
    );
  });

  test('wrong first group should return null TimeOfDay', () {
    var result = buildTimeOfDay(
      "123:45",
    );

    expect(
      result,
      null,
    );
  });

  test('wrong second group should return null TimeOfDay', () {
    var result = buildTimeOfDay(
      "12:345",
    );

    expect(
      result,
      null,
    );
  });

  test('garbage should return null TimeOfDay', () {
    var result = buildTimeOfDay(
      "Hello, World!",
    );

    expect(
      result,
      null,
    );
  });
}
