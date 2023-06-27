import 'package:intl/intl.dart';

class DateTimeConstants {
  static RegExp hourMinuteRegex = RegExp(
    r'^([0-9]{2}):([0-9]{2})$',
  );

  static String dateFormat = "yyyy-MM-dd";

  static String timeFormat = "HH:mm";

  static DateTime get max => DateTime.utc(
        1 << 15,
      );

  static DateTime get min => DateTime.utc(
        0,
      );

  static String get nowDate => DateFormat(
        dateFormat,
      ).format(
        DateTime.now(),
      );

  static String get nowTime => DateFormat(
        timeFormat,
      ).format(
        DateTime.now(),
      );
}
