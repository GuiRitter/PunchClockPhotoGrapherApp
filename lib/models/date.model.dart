import 'package:punch_clock_photo_grapher_app/models/models.import.dart'
    show LoggableModel;
import 'package:punch_clock_photo_grapher_app/utils/utils.import.dart'
    show setEquals;

class DateModel implements LoggableModel {
  final String weekDay;
  final Set<String> timeList;

  DateModel({
    required this.weekDay,
    required this.timeList,
  });

  DateTime get date => DateTime.parse(
        timeList.first,
      ).toLocal();

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
        'weekDay': weekDay,
        'timeList': timeList
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
