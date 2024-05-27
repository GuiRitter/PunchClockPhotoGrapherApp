import 'package:flutter/material.dart' show TimeOfDay;
import 'package:intl/intl.dart' show DateFormat, NumberFormat;
import 'package:punch_clock_photo_grapher_app/common/common.import.dart'
    show Settings;

final timeFormat = NumberFormat(
  '00',
);

DateFormat get dateOnlyFormat => DateFormat(
      'y-MM-dd',
      Settings.locale,
    );

String getISO8601TimeZone({
  required int timeZoneOffsetInMinutes,
}) {
  var hour = timeZoneOffsetInMinutes ~/ 60;
  var minute = timeZoneOffsetInMinutes % 60;

  return '${NumberFormat(
    '+00;-00',
  ).format(
    hour,
  )}:${NumberFormat(
    '00',
  ).format(
    minute,
  )}';
}

extension DateTimeExtension on DateTime {
  DateTime getThisIfNullOrEarlier({
    required DateTime? other,
  }) =>
      (other == null)
          ? this
          : (other.compareTo(
                    this,
                  ) <
                  0)
              ? other
              : this;

  DateTime getThisIfNullOrLater({
    required DateTime? other,
  }) =>
      (other == null)
          ? this
          : (other.compareTo(
                    this,
                  ) <
                  0)
              ? other
              : this;
}

extension DateTimeNullableExtension on DateTime? {
  String? getISO8601() {
    if (this == null) return null;

    return DateFormat(
      '${this!.toIso8601String()}${getISO8601TimeZone(
        timeZoneOffsetInMinutes: this!.timeZoneOffset.inMinutes,
      )}',
      Settings.locale,
    ).format(
      this!,
    );
  }

  String? getISO8601Date() {
    if (this == null) return null;

    return dateOnlyFormat.format(
      this!,
    );
  }

  String? getISO8601Time() {
    if (this == null) return null;

    return '${timeFormat.format(
      this!.hour,
    )}:${timeFormat.format(
      this!.minute,
    )}';
  }
}

extension TimeOfDayNullableExtension on TimeOfDay? {
  String? getISO8601Time() {
    if (this == null) return null;

    return '${timeFormat.format(
      this!.hour,
    )}:${timeFormat.format(
      this!.minute,
    )}';
  }
}
