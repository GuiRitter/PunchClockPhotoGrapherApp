import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat, NumberFormat;

// TODO to extension

final dateOnylFormat = DateFormat(
  'y-MM-dd',
);

final timeFormat = NumberFormat(
  '00',
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

String? getISO8601Time({
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
