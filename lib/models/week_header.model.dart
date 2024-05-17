import 'package:intl/intl.dart' show DateFormat;

final dayFormat = DateFormat(
  "dd",
);

final monthFormat = DateFormat(
  "MM",
);

class WeekHeaderModel {
  final DateTime? start;
  final DateTime? end;

  WeekHeaderModel({
    this.start,
    this.end,
  });

  String get label {
    final startMonth = (start != null)
        ? monthFormat.format(
            start!,
          )
        : "";

    final startDay = (start != null)
        ? dayFormat.format(
            start!,
          )
        : "";

    final endMonth = (end != null)
        ? monthFormat.format(
            end!,
          )
        : "";

    final endDay = (end != null)
        ? dayFormat.format(
            end!,
          )
        : "";

    return ((start != null) && (end != null))
        ? (start!.month == end!.month)
            ? "$startMonth-$startDay/$endDay"
            : "$startMonth-$startDay/$endMonth-$endDay"
        : "";
  }
}
