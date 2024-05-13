import 'package:punch_clock_photo_grapher_app/models/loggable.model.dart';
import 'package:punch_clock_photo_grapher_app/utils/lang.dart';

class DateModel implements LoggableModel {
  final String weekDay;
  final Set<String> timeList;

  DateModel({
    required this.weekDay,
    required this.timeList,
  });

  DateTime get date => DateTime.parse(
        timeList.first,
      );

  @override
  int get hashCode => Object.hashAllUnordered(
        timeList,
      );

  @override
  bool operator ==(
    Object other,
  ) {
    if (other is! DateModel) return false;

    return setEquals(
      timeList,
      other.timeList,
    );
  }

  @override
  Map<String, dynamic> asLog() => <String, dynamic>{
        "weekDay": weekDay,
        "timeList": timeList
            .toList()
            .map(
              (
                time,
              ) =>
                  time,
            )
            .toList(),
      };
}
