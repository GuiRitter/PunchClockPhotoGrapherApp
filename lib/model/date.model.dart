import 'package:flutter/foundation.dart' show setEquals;
import 'package:flutter_guiritter/model/model.import.dart' show LoggableModel;

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

  int get timeCount => timeList.length;

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
        'timeList': timeList.toList(),
      };

  static DateModel clone(
    DateModel model,
  ) =>
      DateModel(
        weekDay: model.weekDay,
        timeList: Set<String>.from(
          model.timeList,
        ),
      );

  static int toTimeCount(
    DateModel model,
  ) =>
      model.timeCount;
}
