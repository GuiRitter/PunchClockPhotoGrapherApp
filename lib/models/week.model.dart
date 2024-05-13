import 'package:punch_clock_photo_grapher_app/models/loggable.model.dart';
import 'package:punch_clock_photo_grapher_app/utils/lang.dart';

class WeekModel implements LoggableModel {
  final int number;
  final Set<String> dateList;

  WeekModel({
    required this.number,
    required this.dateList,
  });

  @override
  int get hashCode => Object.hashAllUnordered(
        dateList,
      );

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
                  date /* .asLog() */,
            )
            .toList(),
      };
}
