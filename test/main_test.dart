import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:punch_clock_photo_grapher_mobile/main.dart';

void main() {
  test(
    'should return TimeOfDay',
    () {
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
    },
  );

  test(
    'wrong first group should return null TimeOfDay',
    () {
      var result = buildTimeOfDay(
        "123:45",
      );

      expect(
        result,
        null,
      );
    },
  );

  test(
    'wrong second group should return null TimeOfDay',
    () {
      var result = buildTimeOfDay(
        "12:345",
      );

      expect(
        result,
        null,
      );
    },
  );

  test(
    'int division should floor',
    () {
      expect(
        int.parse(
              "345",
            ) ~/
            int.parse(
              "60",
            ),
        5,
      );
    },
  );

  test(
    'NumberFormat should display the + sign',
    () {
      expect(
        NumberFormat(
          "+00;-00",
        ).format(
          int.parse(
                "345",
              ) ~/
              int.parse(
                "60",
              ),
        ),
        "+05",
      );
    },
  );

  test(
    'NumberFormat should display the - sign',
    () {
      expect(
        NumberFormat(
          "+00;-00",
        ).format(
          int.parse(
                "-570",
              ) ~/
              int.parse(
                "60",
              ),
        ),
        "-09",
      );
    },
  );

  test(
    'getISO8601TimeZone from Nepal should return +05:45',
    () {
      expect(
        getISO8601TimeZone(
          timeZoneOffsetInMinutes: 345,
        ),
        "+05:45",
      );
    },
  );

  test(
    'getISO8601TimeZone from Greenwich should return +00:00',
    () {
      expect(
        getISO8601TimeZone(
          timeZoneOffsetInMinutes: 0,
        ),
        "+00:00",
      );
    },
  );

  test(
    'getISO8601TimeZone from Marquesas Islands should return -09:30',
    () {
      expect(
        getISO8601TimeZone(
          timeZoneOffsetInMinutes: -570,
        ),
        "-09:30",
      );
    },
  );

  test(
    'garbage should return null TimeOfDay',
    () {
      var result = buildTimeOfDay(
        "Hello, World!",
      );

      expect(
        result,
        null,
      );
    },
  );

  test(
    'should parse date and time',
    () {
      var dateTime = DateTime.parse(
        "2023-06-12T16:32",
      );
      expect(
        dateTime.year,
        2023,
      );
      expect(
        dateTime.month,
        06,
      );
      expect(
        dateTime.day,
        12,
      );
      expect(
        dateTime.hour,
        16,
      );
      expect(
        dateTime.minute,
        32,
      );
    },
  );

  test(
    'getISO8601 should work',
    () {
      var date = "2023-06-12";
      var time = "11:39";

      expect(
        getISO8601(
          date: date,
          time: time,
        ),
        "${date}T$time:00-03:00",
      );
    },
  );
}
