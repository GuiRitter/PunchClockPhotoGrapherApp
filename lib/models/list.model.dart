import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:punch_clock_photo_grapher_app/models/date.model.dart';
import 'package:punch_clock_photo_grapher_app/models/loggable.model.dart';
import 'package:punch_clock_photo_grapher_app/models/state.model.dart';
import 'package:punch_clock_photo_grapher_app/models/week.model.dart';
import 'package:redux/redux.dart';

class ListModel implements LoggableModel {
  final Set<WeekModel> weekList;

  ListModel({
    required List<dynamic> data,
  }) : weekList = data
            .fold(
              Map<int, Map<String, Set<String>>>.identity(),
              (
                previousValue,
                dateTimeWeek,
              ) {
                final weekKey = dateTimeWeek["week"];

                final dateList = previousValue.containsKey(
                  weekKey,
                )
                    ? (previousValue[weekKey] as Map<String, Set<String>>)
                    : Map<String, Set<String>>.identity();

                previousValue[weekKey] = dateList;

                final weekDayKey = DateFormat.E().format(
                  DateTime.parse(
                    dateTimeWeek["date_time"],
                  ),
                );

                final timeList = dateList.containsKey(
                  weekDayKey,
                )
                    ? (dateList[weekDayKey] as Set<String>)
                    : Set<String>.identity();

                dateList[weekDayKey] = timeList;

                timeList.add(
                  dateTimeWeek["date_time"],
                );

                return {
                  ...previousValue,
                  weekKey: dateList,
                };
              },
            )
            .entries
            .map(
              (
                week,
              ) =>
                  WeekModel(
                number: week.key,
                dateList: week.value.entries
                    .map(
                      (
                        date,
                      ) =>
                          DateModel(
                        weekDay: date.key,
                        timeList: date.value,
                      ),
                    )
                    .toSet(),
              ),
            )
            .toSet();

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
        "weekList": weekList
            .toList()
            .map(
              (
                week,
              ) =>
                  week.asLog(),
            )
            .toList(),
      };

  static ListModel? select(
    Store<StateModel> store,
  ) =>
      store.state.list;
}
