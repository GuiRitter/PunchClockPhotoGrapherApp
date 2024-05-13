import 'package:flutter/foundation.dart';
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
              Map<int, dynamic>.identity(),
              (
                previousValue,
                dateTimeWeek,
              ) {
                final key = dateTimeWeek["week"];

                final dateTimeList = previousValue.containsKey(
                  key,
                )
                    ? (previousValue[key] as Set<String>)
                    : Set<String>.identity();

                dateTimeList.add(
                  dateTimeWeek["date_time"],
                );

                return {
                  ...previousValue,
                  key: dateTimeList,
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
                dateList: week.value,
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
