import 'package:flutter/foundation.dart' show setEquals;
import 'package:punch_clock_photo_grapher_app/models/models.import.dart'
    show DateModel, LoggableModel, LoggableSetExtension, WeekHeaderModel;

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
        WeekHeaderModel.aggregate,
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
        'number': number,
        'dateList': dateList.asLog(),
      };
}
