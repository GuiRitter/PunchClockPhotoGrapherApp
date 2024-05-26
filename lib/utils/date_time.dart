import 'package:flutter/material.dart' show TimeOfDay;
import 'package:intl/intl.dart' show DateFormat, NumberFormat;
import 'package:punch_clock_photo_grapher_app/common/common.import.dart'
    show Settings;

final timeFormat = NumberFormat(
  '00',
);

// TODO to extension

DateFormat get dateOnylFormat => DateFormat(
      'y-MM-dd',
      Settings.locale,
    );

String? getISO8601({
  required DateTime? dateTime,
}) {
  if (dateTime == null) {
    return null;
  }
  return DateFormat(
    '${dateTime.toIso8601String()}${getISO8601TimeZone(
      timeZoneOffsetInMinutes: dateTime.timeZoneOffset.inMinutes,
    )}',
    Settings.locale,
  ).format(
    dateTime,
  );
}

String? getISO8601Date({
  required DateTime? dateTime,
}) {
  if (dateTime == null) {
    return null;
  }
  return dateOnylFormat.format(
    dateTime,
  );
}

String? getISO8601TimeFromDateTime({
  required DateTime? dateTime,
}) {
  if (dateTime == null) {
    return null;
  }
  return '${timeFormat.format(
    dateTime.hour,
  )}:${timeFormat.format(
    dateTime.minute,
  )}';
}

String? getISO8601TimeFromTimeOfDay({
  required TimeOfDay? timeOfDay,
}) {
  if (timeOfDay == null) {
    return null;
  }
  return '${timeFormat.format(
    timeOfDay.hour,
  )}:${timeFormat.format(
    timeOfDay.minute,
  )}';
}

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
