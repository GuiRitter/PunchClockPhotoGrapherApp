import 'package:punch_clock_photo_grapher_app/models/date.model.dart';
import 'package:punch_clock_photo_grapher_app/models/loggable.model.dart';
import 'package:punch_clock_photo_grapher_app/models/week_header.model.dart';
import 'package:punch_clock_photo_grapher_app/utils/lang.dart';

class WeekModel implements LoggableModel {
  final int number;
  final Set<DateModel> dateList;

  WeekModel({
    required this.number,
    required this.dateList,
  });

  @override
  int get hashCode => Object.hashAllUnordered(
        dateList,
      );

  String get header => dateList
      .fold(
        WeekHeaderModel(),
        (previousValue, element) => WeekHeaderModel(
          start: (previousValue.start == null)
              ? element.date
              : (previousValue.start!.compareTo(
                        element.date,
                      ) <
                      0)
                  ? previousValue.start
                  : element.date,
          end: (previousValue.end == null)
              ? element.date
              : (previousValue.end!.compareTo(
                        element.date,
                      ) <
                      0)
                  ? element.date
                  : previousValue.end,
        ),
      )
      .label;

  @override
  bool operator ==(
    Object other,
  ) {
    if (other is! WeekModel) return false;

    return setEquals(
      dateList,
      other.dateList,
    );
  }

  @override
  Map<String, dynamic> asLog() => <String, dynamic>{
        "number": number,
        "dateList": dateList
            .toList()
            .map(
              (
                date,
              ) =>
                  date.asLog(),
            )
            .toList(),
      };
}
