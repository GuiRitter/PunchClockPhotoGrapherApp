class DateTimeConstants {
  static DateTime get min => DateTime.utc(0);

  static DateTime get max => DateTime.utc(1 << 15);

  static RegExp hourMinuteRegex = RegExp(r'^([0-9]{2}):([0-9]{2})$');

  static String dateFormat = "yyyy-MM-dd";

  static String timeFormat = "HH:mm";
}
