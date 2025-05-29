import 'dart:math' show max;

import 'package:flutter/foundation.dart' show setEquals;
import 'package:flutter_guiritter/model/_import.dart'
    show LoggableModel, LoggableSetExtension;
import 'package:punch_clock_photo_grapher_app/model/_import.dart'
    show DateModel, WeekHeaderModel;

class WeekModel implements Comparable, LoggableModel {
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

  int get timeCountMax => dateList
      .map(
        DateModel.toTimeCount,
      )
      .reduce(
        max,
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
        'number': number,
        'dateList': dateList.asLog(),
      };

  @override
  int compareTo(
    other,
  ) {
    if (other is! WeekModel) return -1;

    return (number < other.number)
        ? -1
        : (number > other.number)
            ? 1
            : 0;
  }

  static WeekModel clone(
    WeekModel weekModel,
  ) =>
      WeekModel(
        number: weekModel.number,
        dateList: weekModel.dateList
            .map(
              DateModel.clone,
            )
            .toSet(),
      );
}
