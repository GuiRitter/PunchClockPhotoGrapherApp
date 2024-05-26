import 'package:flutter/foundation.dart' show setEquals;
import 'package:intl/intl.dart' show DateFormat;
import 'package:punch_clock_photo_grapher_app/models/models.import.dart'
    show DateModel, LoggableModel, LoggableSetExtension, StateModel, WeekModel;
import 'package:punch_clock_photo_grapher_app/utils/utils.import.dart'
    show MapExtension;
import 'package:redux/redux.dart' show Store;

class ListModel implements LoggableModel {
  final Set<WeekModel> weekList;

  ListModel({
    required List<dynamic> data,
  }) : weekList = getWeekList(
          data: data,
        );

  ListModel.empty() : weekList = Set.identity();

  @override
  int get hashCode => weekList.hashCode;

  @override
  bool operator ==(
    Object other,
  ) {
    if (other is! ListModel) return false;

    return setEquals(
      weekList,
      other.weekList,
    );
  }

  @override
  Map<String, dynamic> asLog() => <String, dynamic>{
        'weekList': weekList.asLog(),
      };

  static Map<String, Set<String>> buildDateList() =>
      Map<String, Set<String>>.identity();

  static DateModel buildDateModel(
    MapEntry<String, Set<String>> date,
  ) =>
      DateModel(
        weekDay: date.key,
        timeList: date.value,
      );

  static Set<String> buildTimeList() => Set<String>.identity();

  static WeekModel buildWeekModel(
    MapEntry<int, Map<String, Set<String>>> week,
  ) =>
      WeekModel(
        number: week.key,
        dateList: week.value.entries
            .map(
              buildDateModel,
            )
            .toSet(),
      );

  static Set<WeekModel> getWeekList({
    required List<dynamic> data,
  }) =>
      data
          .fold(
            Map<int, Map<String, Set<String>>>.identity(),
            populateTimeListByDayByWeekMap,
          )
          .entries
          .map(
            buildWeekModel,
          )
          .toSet();

  static Map<int, Map<String, Set<String>>> populateTimeListByDayByWeekMap(
    Map<int, Map<String, Set<String>>> previousValue,
    dynamic dateTimeWeek,
  ) {
    final weekKey = dateTimeWeek['week'];

    final dateList = previousValue.getValueOrNew(
      key: weekKey,
      generator: buildDateList,
    )!;

    previousValue[weekKey] = dateList;

    final weekDayKey = DateFormat.E().format(
      DateTime.parse(
        dateTimeWeek['date_time'],
      ),
    );

    final timeList = dateList.getValueOrNew(
      key: weekDayKey,
      generator: buildTimeList,
    )!;

    dateList[weekDayKey] = timeList;

    timeList.add(
      dateTimeWeek['date_time'],
    );

    return {
      ...previousValue,
      weekKey: dateList,
    };
  }

  static ListModel? select(
    Store<StateModel> store,
  ) =>
      store.state.list;
}
