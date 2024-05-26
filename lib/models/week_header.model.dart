import 'package:intl/intl.dart' show DateFormat;
import 'package:punch_clock_photo_grapher_app/models/models.import.dart'
    show DateModel;
import 'package:punch_clock_photo_grapher_app/utils/utils.import.dart'
    show DateTimeExtension;

final dayFormat = DateFormat(
  'dd',
);

final monthFormat = DateFormat(
  'MM',
);

class WeekHeaderModel {
  final DateTime? start;
  final DateTime? end;

  WeekHeaderModel({
    this.start,
    this.end,
  });

  WeekHeaderModel.aggregate(
    WeekHeaderModel previousValue,
    DateModel element,
  )   : start = element.date.getThisIfNullOrEarlier(
          other: previousValue.start,
        ),
        end = element.date.getThisIfNullOrLater(
          other: previousValue.end,
        );

  String get label {
    final startMonth = (start != null)
        ? monthFormat.format(
            start!,
          )
        : '';

    final startDay = (start != null)
        ? dayFormat.format(
            start!,
          )
        : '';

    final endMonth = (end != null)
        ? monthFormat.format(
            end!,
          )
        : '';

    final endDay = (end != null)
        ? dayFormat.format(
            end!,
          )
        : '';

    return ((start != null) && (end != null))
        ? (start!.month == end!.month)
            ? '$startMonth-$startDay/$endDay'
            : '$startMonth-$startDay/$endMonth-$endDay'
        : '';
  }
}
